import 'dart:convert';

import "package:geolocator/geolocator.dart";
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';


const String baseUrl =
    'https://api.openrouteservice.org/v2/directions/driving-car';
const String apiKey =
    '5b3ce3597851110001cf624871d85c701b964948bbc350b28d925933';

getRouteUrl(String startPoint, String endPoint) {
  return Uri.parse('$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint');
}

Future<List<LatLng>> getPoints(LatLng? destination) async {
  if(destination == null){
    return List<LatLng>.empty();
  }
  var current = await Geolocator.getCurrentPosition();
  var response = await http.get(
      getRouteUrl(
          "${current.longitude},${current.latitude}",
          "${destination.longitude},${destination.latitude}"
      )
  );
  if (response.statusCode != 200) {
    return List<LatLng>.empty();
  }
  var data = jsonDecode(response.body);
  var points = data['features'][0]['geometry']['coordinates'];
  points = List<LatLng>.from(points.map(
          (p) => LatLng(p[1], p[0])
  ));
  return points;
}