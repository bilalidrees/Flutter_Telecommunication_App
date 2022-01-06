import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:mapbox_geocoding/mapbox_geocoding.dart';
import 'package:mapbox_geocoding/model/reverse_geocoding.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GeoLocationAccess {

  Future<Position> determinePositionTwo() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      //return Future.error('Location services are disabled.');
      return Position(latitude: 33.738045, longitude: 73.084488);
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
        return Position(latitude: 33.738045, longitude: 73.084488);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately

      return Position(latitude: 33.738045, longitude: 73.084488);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<String> determineLocationTwo(Position position) async {
    // final coordinates = new Coordinates(lat, lng);
    print("web");
    var city = await getCity(position.latitude, position.longitude);
    return city;
    // if (kIsWeb) {
    //
    // } else {
    //   print("mobile");
    //   final List<Address> address = await Geocoder.local
    //       .findAddressesFromCoordinates(
    //           Coordinates(position.latitude, position.longitude));
    //   return address.first.locality;
    // }
  }

  Future<String> getCity(double lat, double lng) async {
    MapboxGeocoding geocoding = MapboxGeocoding(
        'pk.eyJ1IjoidmVjdHJhY29tIiwiYSI6ImNrdmh4dGMzbzYyZzEycHF3NHRhb2xpaHAifQ.g3n1w3bQvc0HqiOnv6NOrg');
    try {
      ReverseGeocoding reverseModel =
          await geocoding.reverseModel(lat, lng, limit: 7, types: 'place');
      print(reverseModel.features[0].placeName);
      return reverseModel.features[0].placeName;
    } catch (Excepetion) {
      return 'Reverse Geocoding Error';
    }
  }
}
