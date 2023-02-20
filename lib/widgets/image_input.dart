import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function(File file) onSelectedImage;
  const ImageInput({super.key, required this.onSelectedImage});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  final ImagePicker picker = ImagePicker();

  Future<void> getLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }

    if (response.files != null) {
      for (final XFile file in response.files ?? []) {
        _handleFile(file);
      }
    } else {
      _handleError(response.exception);
    }
  }

  _handleFile(XFile file) {
    setState(() {
      _storedImage = File(file.path);
    });
  }

  _handleError(PlatformException? exception) {
    print(exception);
  }

  _takePicture() async {
    XFile imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final Directory appDir = await syspaths.getApplicationDocumentsDirectory();
    final String fileName = path.basename(imageFile.path);
    final File savedImage = await _storedImage!.copy('${appDir.path}/$fileName');

    widget.onSelectedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text('Nenhuma Imagem!'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Tirar Foto'),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
