import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/common/app_text_button.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'package:online_plants_app/core/utils/util_data.dart';
import 'package:online_plants_app/features/login/presentation/widgets/login_fields.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:path_provider/path_provider.dart';

class ManagePlantsPage extends StatefulWidget {
  const ManagePlantsPage({super.key});

  @override
  _ManagePlantsPageState createState() => _ManagePlantsPageState();
}

class _ManagePlantsPageState extends State<ManagePlantsPage> {
  final _formKey = GlobalKey<FormState>();
  final _plantNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountPriceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _sprayController = TextEditingController();

  String? _selectedCategoryId;
  String? _selectedSubCategory;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPlants();
  }

  Future<void> _loadPlants() async {
    categoriesList.clear();

    QuerySnapshot categoriesSnapshot = await _firestore
        .collection('categories_${Constants.goreshwarId}')
        .get();

    for (var categoryDoc in categoriesSnapshot.docs) {
      String categoryId = categoryDoc.id;
      String categoryValue = categoryDoc['value'];
      List<dynamic> varieties = categoryDoc['varieties'] ?? [];

      List<Map<String, dynamic>> varietiesList = [];

      for (String variety in varieties.cast<String>()) {
        QuerySnapshot plantsSnapshot = await _firestore
            .collection('plants_${Constants.goreshwarId}')
            .where('category', isEqualTo: categoryValue)
            .where('variety', isEqualTo: variety)
            .get();

        List<Map<String, dynamic>> plantsList = plantsSnapshot.docs
            .map((plantDoc) => {
                  'id': plantDoc.id,
                  ...plantDoc.data() as Map<String, dynamic>,
                })
            .toList();

        if (plantsList.isNotEmpty) {
          varietiesList.add({
            'varietyName': variety,
            'plants': plantsList,
          });
        }
      }

      if (varietiesList.isNotEmpty) {
        categoriesList.add({
          'categoryName': categoryValue,
          'varieties': varietiesList,
        });
        print("vari ${varieties.toString()}");
      }
    }

    print("load plants...");
    print('categr : ${categoriesList.toString()}');
  }

  Future<void> _updatePlant() async {
    if (_formKey.currentState!.validate() && selectedPlant != null) {
      String? imageUrl = selectedPlant!['image'];

      if (_image != null) {
        // Delete old image if new one is uploaded
        if (imageUrl != null && imageUrl.isNotEmpty) {
          try {
            await _storage.refFromURL(imageUrl).delete();
          } catch (e) {
            print('Error deleting previous image: $e');
          }
        }
        imageUrl = await _uploadImage();
      }

      final plantData = {
        'plant_name': _plantNameController.text,
        'price': _priceController.text,
        'discount_price': _discountPriceController.text,
        'stock': _stockController.text,
        'description': _descriptionController.text,
        'spray': _sprayController.text.split(',').map((s) => s.trim()).toList(),
        'image': imageUrl,
      };

      await _firestore
          .collection('plants_${Constants.goreshwarId}')
          .doc(selectedPlant!['id'])
          .update(plantData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plant updated successfully!')),
      );

      await _loadPlants();
    }
  }

  Future<String> _uploadImage() async {
    if (_image == null) throw Exception('No image selected');

    // Compress image before uploading
    File? compressedImage = await _compressImage(_image!);
    if (compressedImage == null) throw Exception('Image compression failed');

    final ref = _storage.ref().child(
        'plant_images/${Constants.goreshwarId}/${DateTime.now().toIso8601String()}');

    // Delete the previous image if it exists
    // if (previousImageUrl != null && previousImageUrl.isNotEmpty) {
    //   try {
    //     await _storage.refFromURL(previousImageUrl).delete();
    //   } catch (e) {
    //     print('Error deleting previous image: $e');
    //   }
    // }

    // Upload the compressed image
    await ref.putFile(compressedImage);
    String downloadUrl = await ref.getDownloadURL();

    // Remove the original and compressed images after uploading
    try {
      await _image!.delete(); // Delete the original image
      await compressedImage.delete(); // Delete the compressed image
    } catch (e) {
      print('Error deleting images: $e');
    }

    return downloadUrl;
  }

  Future<File?> _compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        path.join(dir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70, // Adjust quality (0 - 100, lower means more compression)
      format: CompressFormat.jpeg,
    );

    return result != null ? File(result.path) : null;
  }

  List<Map<String, dynamic>> categoriesList = [];
  Map<String, dynamic>? selectedPlant;

  Future<void> _addPlant() async {
    if (_formKey.currentState!.validate() &&
        _selectedCategoryId != null &&
        _selectedSubCategory != null &&
        _image != null) {
      final imageUrl = await _uploadImage();
      final plantData = {
        'plant_name': _plantNameController.text,
        'price': _priceController.text,
        'discount_price': _discountPriceController.text,
        'variety': _selectedSubCategory,
        'category': _selectedCategoryId,
        'image': imageUrl,
        'stock': _stockController.text,
        'description': _descriptionController.text,
        'spray': [_sprayController.text],
        'availability': true,
        'attributes': {
          'height': ['20cm', '30cm'],
          'age': ['1month', '2month']
        },
      };

      await _firestore
          .collection('plants_${Constants.goreshwarId}')
          .add(plantData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Plant added successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all fields!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[welcomeAppBar()];
          },
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                      textController: _plantNameController,
                      hintText: 'Plant Name',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a plant name' : null,
                    ),
                    CustomTextField(
                      textController: _priceController,
                      hintText: 'Price',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a price' : null,
                    ),
                    CustomTextField(
                      textController: _discountPriceController,
                      hintText: 'Discount Price',
                    ),
                    CustomTextField(
                      textController: _stockController,
                      hintText: 'Stock',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter stock quantity' : null,
                    ),
                    CustomTextField(
                      textController: _descriptionController,
                      hintText: 'Description',
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a description' : null,
                    ),
                    CustomTextField(
                      textController: _sprayController,
                      hintText: 'Spray Instructions',
                    ),
                    const SizedBox(height: 20),

                    /// Select Category
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('categories_${Constants.goreshwarId}')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return InAppLoaderWidget();
                        var categories = snapshot.data!.docs;
                        return DropdownButtonFormField<String>(
                          value: _selectedCategoryId,
                          items: categories.map((category) {
                            return DropdownMenuItem(
                              value: category.id,
                              child: Text(category['value']),
                            );
                          }).toList(),
                          onChanged: (categoryId) {
                            setState(() {
                              _selectedCategoryId = categoryId;
                              _selectedSubCategory = null;
                            });
                          },
                          decoration:
                              InputDecoration(labelText: 'Select Category'),
                          validator: (value) =>
                              value == null ? 'Please select a category' : null,
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    /// Select Subcategory (Based on Category)
                    if (_selectedCategoryId != null)
                      StreamBuilder<DocumentSnapshot>(
                        stream: _firestore
                            .collection('categories_${Constants.goreshwarId}')
                            .doc(_selectedCategoryId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return InAppLoaderWidget();
                          var categoryData =
                              snapshot.data!.data() as Map<String, dynamic>;
                          var varieties =
                              categoryData['varieties'] as List<dynamic>? ?? [];

                          return DropdownButtonFormField<String>(
                            value: _selectedSubCategory,
                            items: varieties.map((variety) {
                              return DropdownMenuItem(
                                value: variety.toString(),
                                child: Text(variety),
                              );
                            }).toList(),
                            onChanged: (variety) {
                              setState(() {
                                _selectedSubCategory = variety;
                              });
                            },
                            decoration: InputDecoration(
                                labelText: 'Select Subcategory'),
                            validator: (value) => value == null
                                ? 'Please select a subcategory'
                                : null,
                          );
                        },
                      ),
                    const SizedBox(height: 20),

                    /// Image Picker
                    _image == null
                        ? ElevatedButton(
                            onPressed: _pickImage,
                            child: Text('Pick Image'),
                          )
                        : Image.file(_image!, height: 150),

                    const SizedBox(height: 20),

                    /// Add Plant Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: getWidth(40)),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppTextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    print('validated...... now add....');
                                  }
                                },
                                text: 'Add Plant'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isEditPlants = false;
  Widget welcomeAppBar() {
    return CustomAppBar(
      appBarType: AppBarType.normal,
      title: 'Manage Plants',
      pinned: true,
      floating: true,
      trailingChild: GestureDetector(
        onTap: () => setState(() => isEditPlants = !isEditPlants),
        child: Icon(Icons.edit),
      ),
    );
  }
}
