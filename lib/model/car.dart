class Car {
  final String id;
  final String merekJenis;

  Car({required this.id, required this.merekJenis});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      merekJenis: json['merek_jenis'],
    );
  }
}
