import 'package:autostore/controller/car_contoller.dart';
import 'package:autostore/model/car.dart';
import 'package:flutter/material.dart';

class CarListPage extends StatefulWidget {
  const CarListPage({super.key});

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> {
  late Future<List<Car>> carsData;

  final _carIdController = TextEditingController();
  final _carMerekController = TextEditingController();
  final _carController = CarContoller();

  @override
  void initState() {
    super.initState();
    carsData = _carController.fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side: Form for adding/editing cars
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white, // White background for the form
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Add/Edit Car',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Black text color
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _carIdController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'ID',
                        labelStyle: const TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _carMerekController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Merek/Jenis',
                        labelStyle: const TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Background color
                        foregroundColor: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 24.0,
                        ),
                      ),
                      onPressed: () {
                        _carController.addOrEditCar(
                            _carIdController.text, _carMerekController.text);
                        setState(() {
                          carsData = _carController.fetchCars();
                        });
                      },
                      child: const Text('Add/Edit Car'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Right side: Displaying car list
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<List<Car>>(
                future: carsData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No cars available'));
                  } else {
                    final cars = snapshot.data!;
                    return SingleChildScrollView(
                      child: DataTable(
                        headingTextStyle: const TextStyle(color: Colors.white),
                        dataTextStyle: const TextStyle(color: Colors.white),
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Merek/Jenis')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: cars
                            .map((car) => DataRow(cells: [
                                  DataCell(Text(car.id)),
                                  DataCell(Text(car.merekJenis)),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () => setState(() {
                                          List<String> editCarData =
                                              _carController.editCar(
                                                  car,
                                                  _carIdController.text,
                                                  _carMerekController.text);
                                          _carIdController.text =
                                              editCarData[0];
                                          _carMerekController.text =
                                              editCarData[1];
                                        }),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => setState(() {
                                          _carController.deleteCar(car.id);
                                          carsData = _carController.fetchCars();
                                        }),
                                      ),
                                    ],
                                  )),
                                ]))
                            .toList(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Car List'),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.all(16.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Add/Edit Car',
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //                 TextField(
  //                   controller: _carIdController,
  //                   decoration: InputDecoration(labelText: 'ID'),
  //                 ),
  //                 TextField(
  //                   controller: _carMerekController,
  //                   decoration: InputDecoration(labelText: 'Merek/Jenis'),
  //                 ),
  //                 SizedBox(height: 8),
  //                 ElevatedButton(
  //                   onPressed: addOrEditCar,
  //                   child: Text('Add/Edit Car'),
  //                 ),
  //                 SizedBox(height: 16),
  //                 Text(
  //                   'Car List',
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //                 SingleChildScrollView(
  //                   scrollDirection: Axis.horizontal,
  //                   child: DataTable(
  //                     columns: [
  //                       DataColumn(label: Text('ID')),
  //                       DataColumn(label: Text('Merek/Jenis')),
  //                     ],
  //                     rows: cars
  //                         .map((car) => DataRow(cells: [
  //                               DataCell(Text(car.id)),
  //                               DataCell(Text(car.merekJenis)),
  //                             ]))
  //                         .toList(),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Car List'),
  //     ),
  //     body:
  //        FutureBuilder<List<Car>>(
  //       future: cars,
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return Center(child: Text('Error: ${snapshot.error}'));
  //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //           return const Center(child: Text('No cars available'));
  //         } else {
  //         final cars = snapshot.data!;
  //         return DataTable(
  //           columns: const [
  //             DataColumn(label: Text('ID')),
  //             DataColumn(label: Text('Merek/Jenis')),
  //           ],
  //           rows: cars
  //               .map((car) => DataRow(cells: [
  //                     DataCell(Text(car.id)),
  //                     DataCell(Text(car.merekJenis)),
  //                   ]))
  //               .toList(),
  //         );
  //       }
  //       },
  //     ),
  //   );
  // }
}
