class LocationModel {
  int? id;
  String? name;
  String? latitude;
  String? longitude;
  String? address;
  int? radius;

  LocationModel({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.address,
    this.radius,
  });

  factory LocationModel.fromJson(json) {
    return LocationModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      radius: json['radius'] != null ? int.tryParse(json['radius'].toString()) : null,
    );
  }
}
