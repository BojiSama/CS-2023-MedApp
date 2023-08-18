import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'location_service.dart';
import 'package:logger/logger.dart';

class Hospital extends StatefulWidget {
  const Hospital({super.key});

  @override
  State<Hospital> createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  TextEditingController _searchController = TextEditingController();

  static const LatLng _start = LatLng(0.3326, 32.5686);

  LatLng _currentPostion = LatLng(0.0, 0.0);

  static const CameraPosition _kStart = CameraPosition(
    target: _start,
    zoom: 14.4746,
  );

  final Set<Marker> _markers = <Marker>{};
  final Set<Polyline> _polylines = <Polyline>{};
  int _polylineIdCounter = 1;

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(Polyline(
      polylineId: PolylineId(polylineIdVal),
      width: 2,
      color: Colors.blue,
      points: points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList(),
    ));
  }

  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();

    // _setMarker(LatLng(0.3326, 32.5686), 'Makerere Uni');
    // _myInitState();
    searchFocusNode = FocusNode();
  }

  void _myInitState() async {
    final currPos = await _determinePosition();
    _currentPostion = LatLng(currPos.latitude, currPos.longitude);
    _setMarker(_currentPostion, 'you are here', true);
  }

  @override
  void dispose() {
    searchFocusNode.dispose();

    super.dispose();
  }

  void _setMarker(LatLng point, String id, [bool setHue = false]) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(id),
          position: point,
          infoWindow: InfoWindow(title: id),
          icon: setHue
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
              : BitmapDescriptor.defaultMarker,
          onTap: () async {
            var directions =
                await LocationService().getDirections('Makerere', id);
            _setPolyline(directions['polyline_decoded']);
            var logger = Logger();
            logger.d(_polylines);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // backgroundColor: Colors.red[300],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 1.0),
                    //   borderRadius: BorderRadius.circular(32.0),
                    // ),
                    width: 300,
                    child: TextFormField(
                      focusNode: searchFocusNode,
                      controller: _searchController,
                      textCapitalization: TextCapitalization.words,
                      decoration:
                          const InputDecoration(hintText: 'search by hospital'),
                      onChanged: (value) {
                        // print(value);
                      },
                      textInputAction: TextInputAction.search,
                      onEditingComplete: searchFocusNode.nextFocus,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      _markers.clear();

                      final currPos = await _determinePosition();
                      _currentPostion =
                          LatLng(currPos.latitude, currPos.longitude);
                      _setMarker(_currentPostion, 'you are here', true);

                      final locs = await LocationService()
                          .nearbySearchCoordinates(
                              _searchController.text, _currentPostion);
                      searchFocusNode.nextFocus();
                      // var logger = Logger();
                      for (int i = 0; i < locs.length; i++) {
                        _setMarker(locs[i].position, locs[i].name);
                        // logger.d(locs[i]);
                      }
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
              SizedBox(
                height: 500.0,
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _kStart,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _markers,
                  polylines: _polylines,
                ),
              ),
              // FloatingActionButton(
              //   onPressed: () async {
              //     final loc = await LocationService().nextPage();
              //     _goToCoord(loc);
              //   },
              // ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _currentPos,
          label: const Text('Here'),
          icon: const Icon(Icons.location_city),
        ),
      ),
    );
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _goToCoord(LatLng coord) async {
    CameraPosition cp = CameraPosition(
      target: LatLng(coord.latitude, coord.longitude),
      zoom: 18.0,
    );
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(cp));
    _setMarker(coord, '1001');
  }

  Future<void> _currentPos() async {
    // bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    // print(isLocationServiceEnabled);
    try {
      final Position pos = await _determinePosition();
      CameraPosition cp = CameraPosition(
        target: LatLng(pos.latitude, pos.longitude),
        zoom: 18.0,
        // tilt: 59.0,
      );
      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(cp));
      _setMarker(LatLng(pos.latitude, pos.longitude), 'You are here', true);
    } catch (e) {
      print(e);
    }
    // // await controller.animateCamera(CameraUpdate.newCameraPosition(_kStart));
  }
}
