import 'package:attendance_app/model/location_model.dart';
import 'package:geolocator/geolocator.dart';


class PresenceLocationModel {
  Position current;
  LocationModel? location;

  PresenceLocationModel({required this.current, this.location});
}
