import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

import '../../../widgets/icon_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  String _selectedFilter = 'Todos';

  final List<Map<String, dynamic>> _filters = [
    {
      'name': 'Todos',
      'icon': HugeIcons.strokeRoundedHome01,
      'color': Colors.blue
    },
    {
      'name': 'Veterinarias',
      'icon': HugeIcons.strokeRoundedStore03,
      'color': Colors.orange
    },
    {
      'name': 'Animales en peligro',
      'icon': Icons.pets_outlined,
      'color': Colors.purple
    },
    {
      'name': 'Hospitales',
      'icon': HugeIcons.strokeRoundedHospital02,
      'color': Colors.green
    },
  ];

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(19.6960928, -101.1138323),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print(e);
    }
  }

  void _zoomIn() {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.zoomIn(),
      );
    }
  }

  void _zoomOut() {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.zoomOut(),
      );
    }
  }

  void _goToUserLocation() async {
    if (_currentPosition != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target:
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            zoom: 15,
          ),
        ),
      );
    } else {
      await _getCurrentLocation();
      if (_currentPosition != null && _mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                  _currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 15,
            ),
          ),
        );
      }
    }
  }

  void _selectFilter(String filterName) {
    setState(() {
      _selectedFilter = filterName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        try {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: _initialPosition,
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 20,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 90.w,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    itemBuilder: (context, index) {
                      final filter = _filters[index];
                      final isSelected = _selectedFilter == filter['name'];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () => _selectFilter(filter['name']),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: isSelected
                                    ? filter['color']
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: filter['color'],
                                    width: isSelected ? 2 : 0.5),
                                boxShadow: ShadowStyle.containerShadow2),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 5,
                              children: [
                                Icon(
                                  filter['icon'],
                                  size: 16,
                                  color: isSelected
                                      ? Colors.white
                                      : filter['color'],
                                ),
                                Text(
                                  filter['name'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Colors.white
                                        : filter['color'],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: MediaQuery.of(context).padding.bottom + 5,
                child: Column(
                  children: [
                    IconButtonWidget(
                      onTap: _zoomIn,
                      icon: HugeIcons.strokeRoundedAdd01,
                    ),
                    const SizedBox(height: 8),
                    IconButtonWidget(
                      onTap: _zoomOut,
                      icon: HugeIcons.strokeRoundedMinusSign,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom + 5,
                child: Column(
                  children: [
                    IconButtonWidget(
                      onTap: _goToUserLocation,
                      icon: HugeIcons.strokeRoundedLocationUser03,
                    ),
                  ],
                ),
              ),
            ],
          );
        } catch (e) {
          // Si ocurre un error de plataforma, muestra un mensaje amigable.
          return const Center(
            child: Text(
              'No se pudo cargar el mapa.\nVerifica la configuración de tu plataforma.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          );
        }
      },
    );
  }
}
