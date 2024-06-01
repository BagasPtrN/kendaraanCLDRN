class Bike {
  final String id;
  final String merekJenis;

  Bike({required this.id, required this.merekJenis});

  factory Bike.fromJson(Map<String, dynamic> json) {
    return Bike(
      id: json['id'],
      merekJenis: json['merek_jenis'],
    );
  }
}
