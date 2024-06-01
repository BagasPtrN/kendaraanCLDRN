import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:autostore/model/car.dart';

class CarContoller {
  List<Car> cars = [];

  final String apiUrl =
      'https://motor-lommy4iapq-et.a.run.app/motor'; 

  Future<List<Car>> fetchCars() async {
    final response = await http.get(Uri.parse(apiUrl));

    try {
      final Map<String, dynamic> parsed = json.decode(response.body);
      final List<dynamic> data = parsed['data'];
      cars = data.map((json) => Car.fromJson(json)).toList();
      return cars;
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load cars data');
    }
  }

  Future<void> addOrEditCar(String id, String merekJenis) async {
    if (id.isEmpty || merekJenis.isEmpty) {
      print("dont be empty pls");
      throw Exception('ID and Merek/Jenis cannot be empty');
    } else {
      final existingIndex = cars.indexWhere((car) => car.id == id);
      try {
        if (existingIndex >= 0) {
          try {
            await http.put(
              Uri.parse('$apiUrl/$id'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({'new_id': id, 'merek_jenis': merekJenis}),
            );
            cars[existingIndex] = Car(id: id, merekJenis: merekJenis);
          } catch (e) {
            print("Error: ${e.toString()}");
            throw Exception('Failed to update car');
          }
        } else {
          try {
            await http.post(
              Uri.parse(apiUrl),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({'id': id, 'merek_jenis': merekJenis}),
            );
            cars.add(Car(id: id, merekJenis: merekJenis));
          } catch (e) {
            print("Error: ${e.toString()}");
            throw Exception('Failed to add car');
          }
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  List<String> editCar(Car car, String newId, String newMerk) {
    newId = car.id;
    newMerk = car.merekJenis;
    return [newId, newMerk];
  }

  Future<void> deleteCar(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      cars.removeWhere((car) => car.id == id);
    } else {
      throw Exception('Failed to delete car');
    }
  }


  // Future<List<Car>> fetchCars() async {
  //   // Sample JSON data
  //   final String response = '''
  //   {
  //     "status":"Success",
  //     "message":"Berhasil mengambil daftar mobil",
  //     "data":[
  //       {"id":"0123456789","merek_jenis":"Toyota Innova"},
  //       {"id":"0132456789","merek_jenis":"Toyota Camry"},
  //       {"id":"0987654321","merek_jenis":"Honda Brio"},
  //       {"id":"1123456789","merek_jenis":"Honda Jazz"},
  //       {"id":"1132456789","merek_jenis":"Honda CR-V"},
  //       {"id":"1234567890","merek_jenis":"Toyota Avanza"},
  //       {"id":"2123456789","merek_jenis":"Suzuki Ignis"},
  //       {"id":"2132456789","merek_jenis":"Suzuki SX4"},
  //       {"id":"2345678901","merek_jenis":"Suzuki Ertiga"},
  //       {"id":"3123456789","merek_jenis":"Mitsubishi Mirage"},
  //       {"id":"3132456789","merek_jenis":"Mitsubishi Outlander"},
  //       {"id":"3456789012","merek_jenis":"Mitsubishi Xpander"},
  //       {"id":"4123456789","merek_jenis":"Daihatsu Sigra"},
  //       {"id":"4132456789","merek_jenis":"Daihatsu Luxio"},
  //       {"id":"4567890123","merek_jenis":"Daihatsu Terios"},
  //       {"id":"5123456789","merek_jenis":"Toyota Yaris"},
  //       {"id":"5132456789","merek_jenis":"Toyota Alphard"},
  //       {"id":"5678901234","merek_jenis":"Toyota Fortuner"},
  //       {"id":"6123456789","merek_jenis":"Honda Civic"},
  //       {"id":"6132456789","merek_jenis":"Honda Accord"},
  //       {"id":"6789012345","merek_jenis":"Honda HR-V"},
  //       {"id":"7123456789","merek_jenis":"Suzuki Swift"},
  //       {"id":"7132456789","merek_jenis":"Suzuki Jimny"},
  //       {"id":"7890123456","merek_jenis":"Suzuki Baleno"},
  //       {"id":"8123456789","merek_jenis":"Mitsubishi Lancer"},
  //       {"id":"8132456789","merek_jenis":"Mitsubishi Triton"},
  //       {"id":"8901234567","merek_jenis":"Mitsubishi Pajero Sport"},
  //       {"id":"9012345678","merek_jenis":"Daihatsu Xenia"},
  //       {"id":"9123456789","merek_jenis":"Daihatsu Ayla"},
  //       {"id":"9132456789","merek_jenis":"Daihatsu Gran Max"}
  //     ]
  //   }
  //   ''';

  //   final Map<String, dynamic> parsed = json.decode(response);
  //   final List<dynamic> data = parsed['data'];
  //   return cars = data.map((json) => Car.fromJson(json)).toList();
  // }

  // void addOrEditCar(String id, String merekJenis) {
  //   if (id.isEmpty || merekJenis.isEmpty) return;
  //   final existingIndex = cars.indexWhere((car) => car.id == id);
  //   if (existingIndex >= 0) {
  //     cars[existingIndex] = Car(id: id, merekJenis: merekJenis);
  //   } else {
  //     cars.add(Car(id: id, merekJenis: merekJenis));
  //   }
  // }

  // List<String> editCar(Car car, String newId, String newMerk) {
  //   newId = car.id;
  //   newMerk = car.merekJenis;
  //   return [newId, newMerk];
  // }

  // void deleteCar(String id) {
  //   cars.removeWhere((car) => car.id == id);
  // }
}
