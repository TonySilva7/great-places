import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/utils/db_util.dart';

import '../models/place.dart';
import '../utils/location_utils.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place getItemByIndex(int index) {
    return _items[index];
  }

  Future<void> deleteAll() async {
    await DbUtil.deleteAll('places');
    _items.clear();
    notifyListeners();
  }

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items.clear();

    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: null,
          ),
        )
        .toList();

    notifyListeners();
  }

  Future<void> addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtils.getAddressFrom(position);

    final newPlace = Place(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      image: image,
      location: PlaceLocation(latitude: position.latitude, longitude: position.longitude, address: address),
    );

    _items.add(newPlace);

    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': position.latitude,
      'lng': position.longitude,
      'address': address,
    });

    notifyListeners();
  }
}
