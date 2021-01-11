import 'package:aunty_rafiki/models/bag_item.dart';
import 'package:flutter/material.dart';

class HostipalBagProvider with ChangeNotifier {
  HostipalBagProvider() {
    loadItems();
  }
  //available bag list
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

//laod Item bags
  loadItems() {
    _availableMotherBagList = <BagItem>[
      BagItem(id: 1, name: 'Birth plan', isPacked: false, owner: "mother"),
      BagItem(id: 2, name: 'Book magazine', isPacked: false, owner: "mother"),
      BagItem(id: 3, name: 'Breast pads', isPacked: false, owner: "mother"),
      BagItem(
          id: 4,
          name: 'Camera and batteries',
          isPacked: false,
          owner: "mother"),
      BagItem(id: 5, name: 'Dressing gown', isPacked: false, owner: "mother"),
      BagItem(
          id: 6, name: 'Facecloth of fan', isPacked: false, owner: "mother"),
      BagItem(
          id: 7,
          name: 'Gift for your older children',
          isPacked: false,
          owner: "mother"),
      BagItem(id: 8, name: 'Glucose tablets', isPacked: false, owner: "mother"),
      BagItem(
          id: 9, name: 'Going home outfit', isPacked: false, owner: "mother"),
    ];

    _availablePartnerBagList = <BagItem>[
      BagItem(id: 1, name: 'Birth plan', isPacked: false, owner: "partner"),
      BagItem(id: 2, name: 'Book magazine', isPacked: false, owner: "partner"),
      BagItem(id: 3, name: 'Breast pads', isPacked: false, owner: "partner"),
      BagItem(
          id: 4,
          name: 'Camera and batteries',
          isPacked: false,
          owner: "partner"),
      BagItem(id: 5, name: 'Dressing gown', isPacked: false, owner: "partner"),
      BagItem(
          id: 6, name: 'Facecloth of fan', isPacked: false, owner: "partner"),
      BagItem(
          id: 7,
          name: 'Gift for your older children',
          isPacked: false,
          owner: "partner"),
      BagItem(
          id: 8, name: 'Glucose tablets', isPacked: false, owner: "partner"),
      BagItem(
          id: 9, name: 'Going home outfit', isPacked: false, owner: "partner"),
    ];

    _availableBabyBagList = <BagItem>[
      BagItem(id: 1, name: 'Birth plan', isPacked: false, owner: "baby"),
      BagItem(id: 2, name: 'Book magazine', isPacked: false, owner: "baby"),
      BagItem(id: 3, name: 'Breast pads', isPacked: false, owner: "baby"),
      BagItem(
          id: 4, name: 'Camera and batteries', isPacked: false, owner: "baby"),
      BagItem(id: 5, name: 'Dressing gown', isPacked: false, owner: "baby"),
      BagItem(id: 6, name: 'Facecloth of fan', isPacked: false, owner: "baby"),
      BagItem(
          id: 7,
          name: 'Gift for your older children',
          isPacked: false,
          owner: "baby"),
      BagItem(id: 8, name: 'Glucose tablets', isPacked: false, owner: "baby"),
      BagItem(id: 9, name: 'Going home outfit', isPacked: false, owner: "baby"),
    ];

    notifyListeners();
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
