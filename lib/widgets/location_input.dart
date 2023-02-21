import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/utils/location_utils.dart';
import 'package:location/location.dart';

import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function(LatLng) onSelectedLocation;
  const LocationInput({super.key, required this.onSelectedLocation});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationUtils.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    // lance um erro qualquer

    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude ?? 0, locData.longitude ?? 0);
      widget.onSelectedLocation(LatLng(locData.latitude ?? 0, locData.longitude ?? 0));
    } on Exception catch (e) {
      print("Erro ao pegar a localização: $e");
      // mostrar modal para usuário solicitando a permissão
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erro'),
          content: const Text('Precisamos da sua localização para adicionar às fotos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectedPosition = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      builder: (context) => const MapScreen(),
      fullscreenDialog: true,
    ));

    if (selectedPosition == null) {
      return;
    }

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);

    widget.onSelectedLocation(selectedPosition);
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
