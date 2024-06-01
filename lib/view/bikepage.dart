import 'dart:convert';
import 'package:autostore/controller/bike_controller.dart';
import 'package:autostore/model/bike.dart';
import 'package:flutter/material.dart';

class BikeListPage extends StatefulWidget {
  const BikeListPage({super.key});

  @override
  _BikeListPageState createState() => _BikeListPageState();
}

class _BikeListPageState extends State<BikeListPage> {
  late Future<List<Bike>> bikesData;
  final _bikeIdController = TextEditingController();
  final _bikeMerekController = TextEditingController();
  final _bikeController = BikeController();

  @override
  void initState() {
    super.initState();
    bikesData = _bikeController.fetchBikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side: Form for adding/editing bikes
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
                      'Add/Edit Bike',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Black text color
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _bikeIdController,
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
                      controller: _bikeMerekController,
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
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                      ),
                      onPressed: () {
                        _bikeController.addOrEditBike(
                            _bikeIdController.text, _bikeMerekController.text);
                        setState(() {
                          bikesData = _bikeController.fetchBikes();
                        });
                      },
                      child: const Text('Add/Edit Bike'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Right side: Displaying bike list
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.black, // Light grey background for the table
              child: FutureBuilder<List<Bike>>(
                future: bikesData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No bikes available'));
                  } else {
                    final bikes = snapshot.data!;
                    return DataTable(
                      headingTextStyle: const TextStyle(color: Colors.white),
                      dataTextStyle: const TextStyle(color: Colors.white),
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Merek/Jenis')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: bikes
                          .map((bike) => DataRow(cells: [
                                DataCell(Text(bike.id)),
                                DataCell(Text(bike.merekJenis)),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () => setState(() {
                                        List<String> editBikeData =
                                            _bikeController.editBike(
                                                bike,
                                                _bikeIdController.text,
                                                _bikeMerekController.text);
                                        _bikeIdController.text =
                                            editBikeData[0];
                                        _bikeMerekController.text =
                                            editBikeData[1];
                                      }),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => setState(() {
                                        _bikeController.deleteBike(bike.id);
                                        bikesData =
                                            _bikeController.fetchBikes();
                                      }),
                                    ),
                                  ],
                                )),
                              ]))
                          .toList(),
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
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Text(
  //                   'Add/Edit Bike',
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //                 TextField(
  //                   controller: _bikeIdController,
  //                   decoration: const InputDecoration(labelText: 'ID'),
  //                 ),
  //                 TextField(
  //                   controller: _bikeMerekController,
  //                   decoration: const InputDecoration(labelText: 'Merek/Jenis'),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 ElevatedButton(
  //                   onPressed: () {
  //                 _bikeController.addOrEditBike(
  //                     _bikeIdController.text, _bikeMerekController.text);
  //               },
  //                   child: const Text('Add/Edit Bike'),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 const Text(
  //                   'Bike List',
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //                 FutureBuilder<List<Bike>>(
  //               future: bikesData,
  //               builder: (context, snapshot) {
  //                 if (snapshot.connectionState == ConnectionState.waiting) {
  //                   return const Center(child: CircularProgressIndicator());
  //                 } else if (snapshot.hasError) {
  //                   return Center(child: Text('Error: ${snapshot.error}'));
  //                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //                   return const Center(child: Text('No cars available'));
  //                 } else {
  //                   final bikes = snapshot.data!;
  //                   return DataTable(
  //                     columns: const [
  //                       DataColumn(label: Text('ID')),
  //                       DataColumn(label: Text('Merek/Jenis')),
  //                       DataColumn(label: Text('Actions')),
  //                     ],
  //                     rows: bikes
  //                         .map((bike) => DataRow(cells: [
  //                               DataCell(Text(bike.id)),
  //                               DataCell(Text(bike.merekJenis)),
  //                               DataCell(Row(
  //                                 children: [
  //                                   IconButton(
  //                                     icon: const Icon(Icons.edit),
  //                                     onPressed: () => setState(() {
  //                                       List<String> editBikeData =
  //                                           _bikeController.editBike(
  //                                               bike,
  //                                               _bikeIdController.text,
  //                                               _bikeMerekController.text);
  //                                       _bikeIdController.text = editBikeData[0];
  //                                       _bikeMerekController.text = editBikeData[1];
  //                                     }),
  //                                   ),
  //                                   IconButton(
  //                                       icon: const Icon(Icons.delete),
  //                                       onPressed: () => setState(() {
  //                                             _bikeController.deleteBike(bike.id);
  //                                           })),
  //                                 ],
  //                               )),
  //                             ]))
  //                         .toList(),
  //                   );
  //                 }
  //               },
  //             ),
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
  //       title: const Text('Bike List'),
  //     ),
  //     body: FutureBuilder<List<Bike>>(
  //       future: bikes,
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return Center(child: Text('Error: ${snapshot.error}'));
  //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //           return const Center(child: Text('No bikes available'));
  //         } {
  //         final bikes = snapshot.data!;
  //         return DataTable(
  //           columns: const [
  //             DataColumn(label: Text('ID')),
  //             DataColumn(label: Text('Merek/Jenis')),
  //           ],
  //           rows: bikes
  //               .map((bike) => DataRow(cells: [
  //                     DataCell(Text(bike.id)),
  //                     DataCell(Text(bike.merekJenis)),
  //                   ]))
  //               .toList(),
  //         );
  //       }
  //       },
  //     ),
  //   );
  // }
}
