import 'package:great_places/utils/my_environments.dart';

class LocationUtils {
  static String generateLocationPreviewImage({required double latitude, required double longitude}) {
    const String googleApiKey = MyEnvironments.googleMapsKey;
    const String baseUrl = MyEnvironments.googleMapsURL;

    const String zoom = '13';
    const String size = '600x300';
    const String maptype = 'roadmap';

    return '$baseUrl/staticmap?center=$latitude,$longitude&zoom=$zoom&size=$size&maptype=$maptype&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApiKey';
  }
}


// https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap
// &markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318
// &markers=color:red%7Clabel:C%7C40.718217,-73.998284
// &key=YOUR_API_KEY&signature=YOUR_SIGNATURE