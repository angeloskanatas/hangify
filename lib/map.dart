// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // variables for the map
  late GoogleMapController mapController;
  final LatLng initialLocation =
      const LatLng(37.97410646247914, 23.726828008596772);
  final Set<Marker> _markers = {};

  // list of locations with their corresponding information
  final List<Map<String, dynamic>> locations = [
    {
      'name': 'Beatniks Road Bar',
      'latitude': 37.98481208146746,
      'longitude': 23.734294678378998,
      'description': 'Rock bar with live music and 60\'s, 70\'s vibe'
    },
    {
      'name': 'Retiré at the ERGON House',
      'latitude': 37.97535010321253,
      'longitude': 23.73171933556687,
      'description': 'Medita'
    },
    {
      'name': 'Birdman - Japanese Pub + Grill',
      'latitude': 37.97482389549827,
      'longitude': 23.732679686078864,
      'description':
          'Snug Japanese eatery serving noodles, meat plates, beef nigiri & sandwiches, plus unique cocktails'
    },
    {
      'name': 'Couleur Locale',
      'latitude': 37.9766768713889,
      'longitude': 23.724529149118233,
      'description':
          'Vibrant rooftop bistro with a terrace serving local & global fare, plus cocktails & Acropolis views'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: initialLocation,
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                markers: _markers,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    locations.length, // use the length of the locations list
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(locations[index]['name']),
                    subtitle: Text(locations[index]['description']),
                    onTap: () {
                      // add the corresponding marker to the map when a search result is tapped
                      setState(() {
                        _markers.add(
                          Marker(
                            markerId: MarkerId(locations[index]['name']),
                            position: LatLng(
                              locations[index]['latitude'],
                              locations[index]['longitude'],
                            ),
                            infoWindow: InfoWindow(
                              title: locations[index]['name'],
                            ),
                          ),
                        );
                      });
                      // move the camera to the selected marker
                      mapController.animateCamera(
                        CameraUpdate.newLatLng(
                          LatLng(
                            locations[index]['latitude'],
                            locations[index]['longitude'],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
