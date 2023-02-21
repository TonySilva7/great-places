import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/utils/my_environments.dart';
import 'package:http/http.dart';

class LocationUtils {
  static String googleApiKey = MyEnvironments.googleMapsKey;
  static String baseUrl = MyEnvironments.googleMapsURL;

  static String generateLocationPreviewImage({required double latitude, required double longitude}) {
    const String zoom = '13';
    const String size = '600x300';
    const String maptype = 'roadmap';

    return '$baseUrl/staticmap?center=$latitude,$longitude&zoom=$zoom&size=$size&maptype=$maptype&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    final url = Uri.parse('$baseUrl/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey');

    final Response response = await get(url);
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
