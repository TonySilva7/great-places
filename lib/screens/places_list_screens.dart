import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/routes/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreens extends StatelessWidget {
  const PlacesListScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.placeForm);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: const Center(child: Text('Sem locais para mostrar')),
                builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(greatPlaces.getItemByIndex(i).image),
                          ),
                          title: Text(greatPlaces.getItemByIndex(i).title),
                          subtitle: Text(greatPlaces.getItemByIndex(i).location?.address ?? ''),
                          onTap: () {},
                        ),
                      ),
              ),
      ),
    );
  }
}
