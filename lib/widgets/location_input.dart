import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/utils/location_utils.dart';
import 'package:location/location.dart';

import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();

    final staticMapImageUrl = LocationUtils.generateLocationPreviewImage(
      latitude: locData.latitude ?? 0,
      longitude: locData.longitude ?? 0,
    );

    setState(() {
      previewImageUrl = staticMapImageUrl;
    });

    // final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
    //   latitude: locData.latitude,
    //   longitude: locData.longitude,
    // );
    // setState(() {
    //   previewImageUrl = staticMapImageUrl;
    // });
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedPosition = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      builder: (context) => const MapScreen(),
      fullscreenDialog: true,
    ));

    if (selectedPosition == null) {
      return;
    }

    print(selectedPosition.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          child: previewImageUrl == null
              ? const Text('Nenhuma localização selecionada')
              : Image.network(
                  previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Localização atual'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Selecionar no mapa'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        )
      ],
    );
  }
}
