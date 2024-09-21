import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_plants_app/features/login/data/datasource/Login_datasource.dart';

class LoginDatasourceImpl extends LoginDatasource {
  @override
  Future<List<String>> getLoginImages() async {
    try {
      // Reference to Firestore subcollection
      CollectionReference backupsRef = FirebaseFirestore.instance
          .collection('cloud_images')
          .doc('goreshwar')
          .collection('images');

      // Fetch documents and map to a list of URLs
      var snapshot = await backupsRef.get();
      List<String> imageUrls =
          snapshot.docs.map((doc) => doc['image_url'] as String).toList();

      return imageUrls;
    } catch (e) {
      print('Error fetching images: $e');
      return [];
    }
  }
}
