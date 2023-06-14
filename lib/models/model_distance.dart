class PointDistanceModel {
  late String name;
  late double distance;
  late String description;

  PointDistanceModel({
    required this.name,
    required this.distance,
    required this.description,
  });

  PointDistanceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    distance = json['distance'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'distance': distance,
        'description': description,
      };
}
