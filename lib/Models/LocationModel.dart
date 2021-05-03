class LocationModel {
  double longitude;
  double latitude;

  LocationModel({this.latitude, this.longitude});

  factory LocationModel.fromFactory(Map<String, dynamic> map) {
    return LocationModel(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }
}
