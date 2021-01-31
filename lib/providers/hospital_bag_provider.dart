import 'dart:convert';

import 'package:aunty_rafiki/api/api.dart';
import 'package:aunty_rafiki/models/bag_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HostipalBagProvider with ChangeNotifier {
  //constructor..
  HostipalBagProvider() {
    fetchBagItems();
  }

  //variables...
  bool _isFetchingBagItemsData = false;
  bool _isSubmittingData = false;

  //available bag list
  List<BagItem> _availableBagItemsList = <BagItem>[];

  ///getters
  List<BagItem> get availableBabyBagList => _availableBagItemsList
      .where((element) => element.owner == "baby" && !element.isPacked)
      .toList();
  List<BagItem> get availableMotherBagList => _availableBagItemsList
      .where((element) => element.owner == "mother" && !element.isPacked)
      .toList();
  List<BagItem> get availablePartnerBagList => _availableBagItemsList
      .where((element) => element.owner == "partner" && !element.isPacked)
      .toList();

  List<BagItem> get packedBabyBagList => _availableBagItemsList
      .where((element) => element.owner == "baby" && element.isPacked)
      .toList();
  List<BagItem> get packedMotherBagList => _availableBagItemsList
      .where((element) => element.owner == "mother" && element.isPacked)
      .toList();
  List<BagItem> get packedPartnerBagList => _availableBagItemsList
      .where((element) => element.owner == "partner" && element.isPacked)
      .toList();

  bool get isFetchingBagItemsData => _isFetchingBagItemsData;
  bool get isSubmittingData => _isSubmittingData;

  ///post bag item...
  Future<bool> postBagItem({
    @required String name,
    @required String owner,
    @required String type,
    @required String isPacked,
  }) async {
    bool hasError = true;
    _isSubmittingData = true;

    notifyListeners();

    final Map<String, dynamic> _data = {
      "name": name,
      "owner": owner,
      "type": type,
      "is_packed": isPacked,
      "uid": FirebaseAuth.instance.currentUser.uid,
    };

    notifyListeners();

    try {
      final http.Response response = await http.post(api + "bagItem",
          body: json.encode(_data),
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 201) {
        final _bagItem = BagItem.fromMap(data['bagItem']);
        _availableBagItemsList.add(_bagItem);

        hasError = false;
      }
    } catch (error) {
      print('-----------+++++----------------');
      print(error);

      hasError = true;
    }

    print(_availableBagItemsList.length);
    print("-----------------------------------");
    print(_availableBagItemsList.length);
    print("-----------------------------------");
    _isSubmittingData = false;
    notifyListeners();
    return hasError;
  }

//laod Item bags
  Future<bool> fetchBagItems() async {
    bool hasError = true;
    _isFetchingBagItemsData = true;
    notifyListeners();

    final List<BagItem> _fetchedBagItems = [];
    try {
      final http.Response response = await http.get(
          api + "bagItems/" + FirebaseAuth.instance.currentUser.uid,
          headers: {'Content-Type': 'application/json'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['bagItems'].forEach((bagItemData) {
          final bagItem = BagItem.fromMap(bagItemData);
          _fetchedBagItems.add(bagItem);
        });
        hasError = false;
      }
    } catch (error) {
      print('---------------------------');
      print(error);
      hasError = true;
    }

    _availableBagItemsList = _fetchedBagItems;
    _isFetchingBagItemsData = false;

    print(_availableBagItemsList.length);
    notifyListeners();

    return hasError;
  }

  //pack items...
  packItem({@required BagItem item, @required bool status}) {
    _availableBagItemsList.where((element) => element == item).first.isPacked =
        status;
    notifyListeners();
  }
}
