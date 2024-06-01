import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:autostore/model/bike.dart';

class BikeController {
  List<Bike> bikes = [];
  final String apiUrl =
      'https://motor-lommy4iapq-et.a.run.app/motor'; 

  Future<List<Bike>> fetchBikes() async {
    final response = await http.get(Uri.parse(apiUrl));

    try {
      final Map<String, dynamic> parsed = json.decode(response.body);
      final List<dynamic> data = parsed['data'];
      bikes = data.map((json) => Bike.fromJson(json)).toList();
      return bikes;
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load bikes data');
    }
  }

  Future<void> addOrEditBike(String id, String merekJenis) async {
    if (id.isEmpty || merekJenis.isEmpty) {
      print("dont be empty pls");
      throw Exception('ID and Merek/Jenis cannot be empty');
    } else {
      final existingIndex = bikes.indexWhere((bike) => bike.id == id);
      try {
        if (existingIndex >= 0) {
          try {
            await http.put(
              Uri.parse('$apiUrl/$id'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({'new_id': id, 'merek_jenis': merekJenis}),
            );
            bikes[existingIndex] = Bike(id: id, merekJenis: merekJenis);
          } catch (e) {
            print("Error: ${e.toString()}");
            throw Exception('Failed to update bike');
          }
        } else {
          try {
            await http.post(
              Uri.parse(apiUrl),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({'id': id, 'merek_jenis': merekJenis}),
            );
            bikes.add(Bike(id: id, merekJenis: merekJenis));
          } catch (e) {
            print("Error: ${e.toString()}");
            throw Exception('Failed to add bike');
          }
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  List<String> editBike(Bike bike, String newId, String newMerk) {
    newId = bike.id;
    newMerk = bike.merekJenis;
    return [newId, newMerk];
  }

  Future<void> deleteBike(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      bikes.removeWhere((bike) => bike.id == id);
    } else {
      throw Exception('Failed to delete bike');
    }
  }
}

// class BikeController{
//   List<Bike> bikes = [];

//   Future<List<Bike>> fetchBikes() async {
//     // Sample JSON data
//     final String response = '''
//     {
//       "status":"Success",
//       "message":"Berhasil mengambil daftar sepeda motor",
//       "data":[
//         {"id":"0123456789","merek_jenis":"Yamaha NMAX"},
//         {"id":"0132456789","merek_jenis":"Honda Beat"},
//         {"id":"0987654321","merek_jenis":"Suzuki GSX-R150"},
//         {"id":"1123456789","merek_jenis":"Kawasaki Ninja"},
//         {"id":"1132456789","merek_jenis":"Yamaha R15"},
//         {"id":"1234567890","merek_jenis":"Honda CBR150R"},
//         {"id":"2123456789","merek_jenis":"Kawasaki Z250"},
//         {"id":"2132456789","merek_jenis":"Suzuki V-Strom"},
//         {"id":"2345678901","merek_jenis":"Yamaha MT-25"},
//         {"id":"3123456789","merek_jenis":"Honda ADV150"},
//         {"id":"3132456789","merek_jenis":"Suzuki Satria"},
//         {"id":"3456789012","merek_jenis":"Yamaha XSR155"},
//         {"id":"4123456789","merek_jenis":"Kawasaki W175"},
//         {"id":"4132456789","merek_jenis":"Suzuki Nex II"},
//         {"id":"4567890123","merek_jenis":"Honda PCX160"}
//       ]
//     }
//     ''';

//     final Map<String, dynamic> parsed = json.decode(response);
//     final List<dynamic> data = parsed['data'];
//     return bikes = data.map((json) => Bike.fromJson(json)).toList();
//   }

//   void addOrEditBike(String id, String merekJenis) {
//     if (id.isEmpty || merekJenis.isEmpty) return;
//       final existingIndex = bikes.indexWhere((bike) => bike.id == id);
//       if (existingIndex >= 0) {
//         bikes[existingIndex] = Bike(id: id, merekJenis: merekJenis);
//       } else {
//         bikes.add(Bike(id: id, merekJenis: merekJenis));
//       }
//   }

//    List<String> editBike(Bike bike, String newId, String newMerk) {
//     newId = bike.id;
//     newMerk = bike.merekJenis;
//     return [newId, newMerk];
//   }

//   void deleteBike(String id) {
//     bikes.removeWhere((car) => car.id == id);
//   }
// }