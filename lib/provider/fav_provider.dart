import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> get favorites => _favoriteIds;

  FavoriteProvider() {
    loadFavorites();
  }

  // toggle favorites states
  void toggleFavorite(DocumentSnapshot product) async {
    String productId = product.id;
    String deviceId = await _getDeviceId();
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      await _removeFavorite(productId, deviceId); // remove from favorite
    } else {
      _favoriteIds.add(productId);
      await _addFavorite(productId, deviceId); // add to favorite
    }
    notifyListeners();
  }

  // check if a product is favorited
  bool isExist(DocumentSnapshot product) {
    return _favoriteIds.contains(product.id);
  }

  // add favorites to firestore
  Future<void> _addFavorite(String productId, String deviceId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).set({
        'isFavorite': true,
        'deviceId': deviceId, // add deviceId to the document
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // remove favorite from firestore
  Future<void> _removeFavorite(String productId, String deviceId) async {
    try {
      await _firestore
          .collection("userFavorite")
          .where('deviceId', isEqualTo: deviceId)
          .where(FieldPath.documentId, isEqualTo: productId)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // load favorites from firestore (store favorite or not)
  Future<void> loadFavorites() async {
    try {
      String deviceId = await _getDeviceId();
      QuerySnapshot snapshot = await _firestore
          .collection("userFavorite")
          .where('deviceId', isEqualTo: deviceId)
          .get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<String> _getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) { // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor??''; 
  } else if(Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id; // unique ID on Android
  }else {
    return '';
  }
}

  // Static method to access the provider from any context
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
