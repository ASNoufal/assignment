class Datamodel {
  final String id;
  final String name;
  final String mapdetailsforretailer;
  final String lat;
  final String lon;

  Datamodel({
    required this.id,
    required this.name,
    this.mapdetailsforretailer = '',
    this.lat = '',
    this.lon = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "mapdetailsforretailer": mapdetailsforretailer,
      "lat": lat,
      "lon": lon
    };
  }

  static Datamodel fromJson(Map<String, dynamic> json) {
    return Datamodel(id: json['id'], name: json['name']);
  }
}
