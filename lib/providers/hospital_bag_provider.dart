import 'dart:convert';

import 'package:aunty_rafiki/api/api.dart';
import 'package:aunty_rafiki/models/bag_item.dart';
import 'package:aunty_rafiki/service/database/query-builder/items_query_builder.dart';
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

  ///product query builder
  BagItemQueryBuilder _bagItemQueryBuilder = BagItemQueryBuilder();

  //available bag list
  List<BagItem> _availableBagItemsList = <BagItem>[];
  List<BagItem> _availableBabyBagList = <BagItem>[];
  List<BagItem> _availableMotherBagList = <BagItem>[];
  List<BagItem> _availablePartnerBagList = <BagItem>[];

  //available bag list
  List<BagItem> _packedBabyBagList = <BagItem>[];
  List<BagItem> _packedMotherBagList = <BagItem>[];
  List<BagItem> _packedPartnerBagList = <BagItem>[];

  //getters
  List<BagItem> get availableBabyBagList => _availableBabyBagList;
  List<BagItem> get availableMotherBagList => _availableMotherBagList;
  List<BagItem> get availablePartnerBagList => _availablePartnerBagList;

  List<BagItem> get packedBabyBagList => _packedBabyBagList;
  List<BagItem> get packedMotherBagList => _packedMotherBagList;
  List<BagItem> get packedPartnerBagList => _packedPartnerBagList;

    bool get isFetchingBagItemsData => _isFetchingBagItemsData;

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

  testfetchBagItems() async {
    await _bagItemQueryBuilder.getAllBagItems().then((bagIltemList) {
      bagIltemList.forEach((element) {
        if (element.owner == 'mother') _availableMotherBagList.add(element);
        if (element.owner == 'baby') _availableBabyBagList.add(element);
        if (element.owner == 'partner') _availablePartnerBagList.add(element);
      });
      notifyListeners();
    });
  }

  //pack items...
  packBabyItem(BagItem item) {
    _availableBabyBagList.remove(item);
    _packedBabyBagList.add(item);
    notifyListeners();
  }

  packMotherItem(BagItem item) {
    _availableMotherBagList.remove(item);
    _packedMotherBagList.add(item);
    notifyListeners();
  }

  packPartnerItem(BagItem item) {
    _availablePartnerBagList.remove(item);
    _packedPartnerBagList.add(item);
    notifyListeners();
  }

  //unpack items
  unpackBabyItem(BagItem item) {
    _packedBabyBagList.remove(item);
    _availableBabyBagList.add(item);
    notifyListeners();
  }

  unpackMotherItem(BagItem item) {
    _packedMotherBagList.remove(item);
    _availableMotherBagList.add(item);
    notifyListeners();
  }

  unpackPartnerItem(BagItem item) {
    _availablePartnerBagList.add(item);
    _packedPartnerBagList.remove(item);
    notifyListeners();
  }
}
