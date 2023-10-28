class Datamodel {
  final String id;
  final String name;
  final String mapdetailsforretailer;

  Datamodel({
    required this.id,
    required this.name,
    this.mapdetailsforretailer = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "mapdetailsforretailer": mapdetailsforretailer,
    };
  }

  static Datamodel fromJson(Map<String, dynamic> json) {
    return Datamodel(id: json['id'], name: json['name']);
  }
}
