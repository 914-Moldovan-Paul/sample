// SupplyDetailsScreen.dart

import 'package:flutter/material.dart';
import '../models/item.dart';
import '../api/api.dart';

class SupplyDetailsScreen extends StatefulWidget {
  final int supplyId;

  SupplyDetailsScreen({required this.supplyId});

  @override
  _SupplyDetailsScreenState createState() => _SupplyDetailsScreenState();
}

class _SupplyDetailsScreenState extends State<SupplyDetailsScreen> {
  late Item medicalSupply;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMedicalSupplyDetails();
  }

  Future<void> fetchMedicalSupplyDetails() async {
    try {
      final Item supply = await ApiService.instance.getMedicalSupplyById(widget.supplyId);
      setState(() {
        medicalSupply = supply;
        isLoading = false; // Set isLoading to false once data is loaded
      });
    } catch (e) {
      // Handle error
      print('Error fetching medical supply details: $e');
      setState(() {
        isLoading = false; // Set isLoading to false in case of an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supply Details'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${medicalSupply.name}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('ID: ${medicalSupply.id}'),
                  Text('Supplier: ${medicalSupply.supplier}'),
                  Text('Details: ${medicalSupply.details}'),
                  Text('Status: ${medicalSupply.status}'),
                  Text('Quantity: ${medicalSupply.quantity}'),
                  Text('Type: ${medicalSupply.type}'),
                ],
              ),
            ),
    );
  }
}
