import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';
import 'package:online_plants_app/core/services_data/data/datasource/seller_datasource.dart';
import 'package:online_plants_app/core/services_data/model/seller_model.dart';

class SellerDatasourceImpl extends SellerDatasource {
  final HivePref hivePref;
  SellerDatasourceImpl({required this.hivePref});

  @override
  Future<SellerModel?> getSellerDetail(String id) async {
    try {
      SellerModel? seller = await hivePref.getSellerDetail(id);
      if (seller != null) {
        return seller;
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference sellerDocRef = firestore.collection('Sellers').doc(id);
      DocumentSnapshot sellerDoc = await sellerDocRef.get();
      if (!sellerDoc.exists) {
        return null;
      } else {
        Map<String, dynamic> sellerData =
            sellerDoc.data() as Map<String, dynamic>;
        SellerModel model = SellerModel.fromJson(sellerData);
        hivePref.setSellerDetail(model);
        return model;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SellerModel> setSellerDetail(SellerModel sellerModel) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference sellerDocRef =
          firestore.collection('Sellers').doc(sellerModel.id);

      DocumentSnapshot sellerDoc = await sellerDocRef.get();

      if (!sellerDoc.exists) {
        await sellerDocRef.set(sellerModel.toJson());
      } else {
        Map<String, dynamic> sellerData =
            sellerDoc.data() as Map<String, dynamic>;
        SellerModel prevModel = SellerModel.fromJson(sellerData);

        SellerModel newModel = SellerModel(
          id: prevModel.id,
          name: sellerModel.name,
          email: sellerModel.email,
          mobileNo: sellerModel.mobileNo,
          isActive: sellerModel.isActive,
          createdDate: sellerModel.createdDate,
          updatedDate: DateTime.now().toIso8601String(),
          address: sellerModel.address,
          imageUrl: sellerModel.imageUrl,
          mainNurseryName: sellerModel.mainNurseryName,
        );

        await sellerDocRef.update(newModel.toJson());
      }

      DocumentSnapshot updatedSellerDoc = await sellerDocRef.get();
      if (updatedSellerDoc.exists) {
        Map<String, dynamic> sellerData =
            updatedSellerDoc.data() as Map<String, dynamic>;
        SellerModel model = SellerModel.fromJson(sellerData);
        hivePref.setSellerDetail(model);
        return model;
      } else {
        throw Exception('User document not found after update');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
