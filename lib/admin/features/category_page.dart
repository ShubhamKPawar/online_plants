import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/common/app_text_button.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'package:online_plants_app/core/utils/util_data.dart';
import 'package:online_plants_app/features/login/presentation/widgets/login_fields.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _categoryFormKey = GlobalKey<FormState>();
  final _subCategoryFormKey = GlobalKey<FormState>();

  final _categoryController = TextEditingController();
  final _editCategoryController = TextEditingController();
  final _subCategoryController = TextEditingController();

  bool isAddCategory = true;
  bool isLoading = false; // For showing loaders

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? selectedCategoryId;
  String? selectedEditCategoryId;

  Stream<List<Map<String, dynamic>>> getCategories() {
    return _firestore
        .collection('categories_${Constants.goreshwarId}')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {'id': doc.id, 'value': doc['value']})
            .toList());
  }

  Future<void> _addCategory() async {
    if (_categoryFormKey.currentState!.validate()) {
      setState(() => isLoading = true);
      await _firestore.collection('categories_${Constants.goreshwarId}').add({
        'value': _categoryController.text,
        'varieties': [],
      });
      _categoryController.clear();
      setState(() => isLoading = false);
      showSnackbar(context, 'Category Added', AppColor.skGreen);
    } else {
      showSnackbar(context, 'Please Enter Category', AppColor.skGreen);
    }
  }

  Future<void> _editCategory(String id, String newValue) async {
    setState(() => isLoading = true);
    await _firestore
        .collection('categories_${Constants.goreshwarId}')
        .doc(id)
        .update({'value': newValue});

    setState(() => isLoading = false);
    showSnackbar(context, 'Category Updated', AppColor.skGreen);
  }

  Future<void> _addSubCategory() async {
    if (_subCategoryFormKey.currentState!.validate() &&
        selectedCategoryId != null) {
      setState(() => isLoading = true);
      await _firestore
          .collection('categories_${Constants.goreshwarId}')
          .doc(selectedCategoryId)
          .update({
        'varieties': FieldValue.arrayUnion([_subCategoryController.text]),
      });
      _subCategoryController.clear();
      setState(() => isLoading = false);
      showSnackbar(context, 'Subcategory Added', AppColor.skGreen);
    } else {
      showSnackbar(context, 'Please select a category', AppColor.skRed);
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
          body: StreamBuilder<List<Map<String, dynamic>>>(
            stream: getCategories(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: InAppLoaderWidget());
              }

              final categories = snapshot.data!;

              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        isAddCategory
                            ? _buildAddCategoryForm()
                            : _buildEditCategoryForm(categories),
                        SizedBox(height: 20),
                        _buildAddSubCategoryForm(categories),
                      ],
                    ),
                  ),
                  if (isLoading)
                    Center(
                      child: InAppLoaderWidget(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAddCategoryForm() {
    return Form(
      key: _categoryFormKey,
      child: Column(
        children: [
          CustomTextField(
            textController: _categoryController,
            hintText: 'Category Name',
            validator: (value) =>
                value == null || value.isEmpty ? 'Enter Category Name' : null,
          ),
          SizedBox(height: 20),
          _buildActionButton('Add Category', _addCategory),
        ],
      ),
    );
  }

  Widget _buildEditCategoryForm(List<Map<String, dynamic>> categories) {
    return Column(
      children: [
        DropdownButton<String>(
          value: selectedEditCategoryId,
          hint: Text('Select a category'),
          isExpanded: true,
          items: categories.map((category) {
            return DropdownMenuItem<String>(
              value: category['id'],
              child: Text("${category['value']}"),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedEditCategoryId = value;
              final selectedCategory =
                  categories.firstWhere((cat) => cat['id'] == value);
              _editCategoryController.text = selectedCategory['value'];
            });
          },
        ),
        SizedBox(height: 20),
        CustomTextField(
          textController: _editCategoryController,
          hintText: 'Edit Category Name',
        ),
        SizedBox(height: 20),
        _buildActionButton('Edit Category', () {
          if (selectedEditCategoryId != null &&
              _editCategoryController.text.isNotEmpty) {
            _editCategory(
                selectedEditCategoryId!, _editCategoryController.text);
          } else {
            if (_editCategoryController.text.isEmpty) {
              showSnackbar(context, 'enter a category to edit', AppColor.skRed);
            } else {
              showSnackbar(
                  context, 'Select a category to edit', AppColor.skRed);
            }
          }
        }),
      ],
    );
  }

  Widget _buildAddSubCategoryForm(List<Map<String, dynamic>> categories) {
    return Form(
      key: _subCategoryFormKey,
      child: Column(
        children: [
          CustomTextField(
            textController: _subCategoryController,
            hintText: 'Subcategory Name',
            validator: (value) => value == null || value.isEmpty
                ? 'Enter Subcategory Name'
                : null,
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            value: selectedCategoryId,
            hint: Text('Select a category'),
            isExpanded: true,
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category['id'],
                child: Text(category['value']),
              );
            }).toList(),
            onChanged: (value) => setState(() => selectedCategoryId = value),
          ),
          SizedBox(height: 20),
          _buildActionButton('Add Subcategory', _addSubCategory),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: getWidth(200),
      child: AppTextButton(
        onPressed: onPressed,
        text: text,
      ),
    );
  }

  Widget welcomeAppBar() {
    return CustomAppBar(
      appBarType: AppBarType.normal,
      title: 'Add Category',
      pinned: true,
      floating: true,
      trailingChild: GestureDetector(
        onTap: () => setState(() => isAddCategory = !isAddCategory),
        child: Icon(Icons.edit),
      ),
    );
  }
}
