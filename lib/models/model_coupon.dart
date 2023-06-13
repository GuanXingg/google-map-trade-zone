class CouponModel {
  late int id;
  late String name;
  late String description;
  late String expired;
  late String place;

  CouponModel({
    required this.id,
    required this.name,
    required this.description,
    required this.expired,
    required this.place,
  });

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    expired = json['expired'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'expired': expired,
        'place': place,
      };
}
