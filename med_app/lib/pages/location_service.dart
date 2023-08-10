import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  // static dynamic json;
  // String place = '';

  // void _request(String input) async {
  //   final String url =
  //       "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$input&type=hospital&key=$apiKey&radius=10000";

  //   var response = await http.get(Uri.parse(url));
  //   json = convert.jsonDecode(response.body);
  //   place = input;
  // }

  Future<LatLng> coordinates(String input) async {
    dynamic lat, lng, nextPageToken = '';
    dynamic json;
    // Future.doWhile(() async {
    // final String url =
    //     "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$input&type=hospital&key=$apiKey&pagetoken=$nextPageToken&radius=10000";
    // final String url =
    //     "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=hospital&&components=country:ug&key=$apiKey&radius=10000";

    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=$input&type=hospital&key=$apiKey&radius=10000";

    var response = await http.get(Uri.parse(url));
    // Future.delayed(const Duration(seconds:1));
    json = convert.jsonDecode(response.body);

    // lat = json['results'][0]['geometry']['location']['lat'];
    // lng = json['results'][0]['geometry']['location']['lng'];
    // nextPageToken = null;
    // nextPageToken = json['next_page_token'];
    var len = json['results'].length;
    print('length = ' + '\n');
    String jj = json.toString();
    
    print('\n');
    //   return !(nextPageToken==null);
    // });
    return LatLng(lat, lng);
  }

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
      // possibleLocations.add(LatLng(lat, lng));
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

  Future<LatLng> nextPage() async {
    String input = '';
    final String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$input&type=hospital&key=$apiKey&radius=10000";

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var nextPageToken = json['next_page_token'];

    final String next_page_search =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=$nextPageToken&key=$apiKey";

    // var response = await http.get(Uri.parse(next_page_search));
    // var json = convert.jsonDecode(response.body);
    var lng = json['results'][0]['geometry']['location']['lng'];
    var lat = json['results'][0]['geometry']['location']['lat'];

    return LatLng(lat, lng);
  }
  // Future<Image> image(String input) async {

  // }
}
