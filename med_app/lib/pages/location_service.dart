import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:logger/logger.dart';

class Place{
  final LatLng position;
  final String name;

  Place(this.position, this.name);
}
class LocationService {
  final String apiKey = 'AIzaSyAw3RLzK2HmYx3QpbTnRqkPozhx81Lnvbk';

  var logger = Logger();
  static final List<Place> possibleLocations = <Place>[];


  Future<dynamic> nearbySearch(String keyword, LatLng location) async {
    dynamic json, lat, lng;
    lat = location.latitude;
    lng = location.longitude;
    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=$keyword&location=$lat%2C$lng&type=hospital&key=$apiKey&radius=1000";

    var response = await http.get(Uri.parse(url));
    json = convert.jsonDecode(response.body);
    return json;
  }

  Future<List<Place>> nearbySearchCoordinates(String keyword, LatLng location) async {
    dynamic lat, lng;
    lat = location.latitude;
    lng = location.longitude;
    final locs = <Place>[];
    final json = await nearbySearch(keyword, location);

    var len = json['results'].length;
    for(int i=0; i<len; i++){
      lat = json['results'][i]['geometry']['location']['lat'];
      lng = json['results'][i]['geometry']['location']['lng'];
      dynamic name = json['results'][i]['name'];
      // logger.d(possibleLocations[i]);
      locs.add(Place(LatLng(lat, lng), name));
      logger.d(locs[i]);
    }

    // logger.d(len);
    // var logger = Logger();
    logger.d(json);
    // lat = lng = 0.0;

    return locs;
  }
  
  Future<Map<String, dynamic>> getDirections(String origin, String destination) async {
    final String url = "https://maps.googleapis.com/maps/api/directions/json?destination=$destination&origin=$origin&&region=ug&key=$apiKey";
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    var results = {
      "bounds_ne": json['routes'][0]['bounds']['northeast'],
      "bounds_sw": json['routes'][0]['bounds']['southwest'],
      "start_location": json['routes'][0]['legs'][0]['start_location'],
      "end_location": json['routes'][0]['legs'][0]['end_location'],
      "polyline": json['routes'][0]['overview_polyline']['points'],
      "polyline_decoded": PolylinePoints().decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };

    // logger.d(json);

    return results;
  }
}
