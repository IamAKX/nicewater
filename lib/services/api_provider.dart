import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:nice_water/models/google_map_address_model.dart';

enum ApiStatus { ideal, loading, success, failed }

class ApiProvider extends ChangeNotifier {
  ApiStatus? status = ApiStatus.ideal;
  late Dio _dio;
  static ApiProvider instance = ApiProvider();
  ApiProvider() {
    _dio = Dio();
  }

  Future<GoogleMapAddressModel> getAddressFromLatLon(LatLng latLng) async {
    GoogleMapAddressModel? address;
    String key = 'AIzaSyCSxA_G1O-WCyrZmhFe-Qdt04H1ODmzdJ8';
    String api =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$key';
    Response response = await _dio.get(
      api,
      options: Options(
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );
    address = GoogleMapAddressModel.fromJson(response.data);
    return address;
  }
}
