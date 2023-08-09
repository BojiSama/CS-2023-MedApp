import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String apiKey = 'AIzaSyAw3RLzK2HmYx3QpbTnRqkPozhx81Lnvbk';
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
    dynamic lat, lng, nextPageToken='';
    dynamic json;
    Future.doWhile(() async {
      final String url =
          "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$input&type=hospital&key=$apiKey&pagetoken=$nextPageToken&radius=10000";

      var response = await http.get(Uri.parse(url));
      // Future.delayed(const Duration(seconds:1));
      json = convert.jsonDecode(response.body);

      lat = json['results'][0]['geometry']['location']['lat'];
      lng = json['results'][0]['geometry']['location']['lng'];
      nextPageToken = null;
      nextPageToken = json['next_page_token'];

      String jj = json.toString();
      print(jj);
      print('\n');
      return !(nextPageToken==null);
    });
    return LatLng(lat, lng);
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
