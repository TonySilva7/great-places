import 'dart:convert';
import 'dart:io';

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;

  const Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });

  static Place fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'],
      title: map['title'],
      location: PlaceLocation(
        latitude: map['loc_lat'],
        longitude: map['loc_lng'],
        address: map['address'],
      ),
      image: File(map['image']),
    );
  }

  static Map<String, dynamic> toMap(Place place) {
    return {
      'id': place.id,
      'title': place.title,
      'loc_lat': place.location?.latitude,
      'loc_lng': place.location?.longitude,
      'address': place.location?.address,
      'image': place.image.path,
    };
  }

  // convert Map to JSON
  static String toJson(Place place) {
    return jsonEncode(toMap(place));
  }

  // convert JSON to Map
  static Place fromJson(String json) {
    return fromMap(jsonDecode(json));
  }

  @override
  String toString() {
    return 'Place(id: $id, title: $title, location: $location, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Place &&
        other.id == id &&
        other.title == title &&
        other.location == location &&
        other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ location.hashCode ^ image.hashCode;
}

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}
