import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ufone_web/src/ui/pages/geo_location_access/geo_location_access.dart';
enum GeoLocationState { initial, loading, loaded }
class GeoLocationProvider with ChangeNotifier{
  final GeoLocationAccess _geoLocationAccess;
  GeoLocationProvider(this._geoLocationAccess){
    getPosAndLocation();
  }
  GeoLocationState _state = GeoLocationState.initial;
  GeoLocationState get state => _state;
  String _city = '';
  String get city => _city;
  Position get position => _position;
  Position _position = Position(latitude: 0.0, longitude: 0.0);
  setGeoState(GeoLocationState stat) {
    _state = stat;
    notifyListeners();
  }
  setPosition(Position pos) {
    _position = pos;
    notifyListeners();
  }
  setLocality(String value) {
    _city = value;
    notifyListeners();
  }

  Future<void> getPosAndLocation()async{
    setGeoState(GeoLocationState.loading);
    await _geoLocationAccess.determinePositionTwo().then((value) {
      print("bilal ${value.latitude},${value.longitude}");
      setPosition(value);
    });
    await _geoLocationAccess.determineLocationTwo(_position).then((value) {
      print('axn $value');
      setLocality(value);
    });
    setGeoState(GeoLocationState.loaded);
  }
}