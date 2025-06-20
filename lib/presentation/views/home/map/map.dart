import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //GoogleMapController? _mapController;

  /* final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(19.432608, -99.133209), // Ejemplo: Ciudad de México
    zoom: 12,
  ); */

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
          "Map"), /* Builder(
        builder: (context) {
          try {
            return GoogleMap(
              initialCameraPosition: _initialPosition,
              onMapCreated: (controller) {
                _mapController = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
            );
          } catch (e) {
            // Si ocurre un error de plataforma, muestra un mensaje amigable.
            return Center(
              child: Text(
                'No se pudo cargar el mapa.\nVerifica la configuración de tu plataforma.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
        },
      ) */
    );
  }
}
