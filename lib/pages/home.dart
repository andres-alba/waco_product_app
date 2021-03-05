import 'package:waco_product_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waco_product_app/pages/list_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Map<String, dynamic> productToAdd;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');

  addProduct() {
    productToAdd = {
      "name": nameController.text,
      "price": priceController.text,
      "stock": stockController.text,
      "description": descriptionController.text,
    };
    collectionReference
        .add(productToAdd)
        .whenComplete(() => print('Added to databse'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Sign Out',
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'Check out cart',
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ListScreen()));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Text(
                  "Add a waco service product!",
                  style: TextStyle(color: Colors.black, fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50.0),
                _buildTextField(nameController, 'Name'),
                SizedBox(height: 20.0),
                _buildTextField(priceController, 'Price'),
                SizedBox(height: 20.0),
                _buildTextField(stockController, 'Stock'),
                SizedBox(height: 20.0),
                _buildTextField(descriptionController, 'Description'),
                SizedBox(height: 20.0),
                FlatButton(
                  child: Text(
                    'Add Product to Cart',
                  ),
                  color: Colors.green,
                  onPressed: () {
                    addProduct();
                  },
                ),
              ],
            ),
          ),
        ));
  }

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none),
      ),
    );
  }
}
