import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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

  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  CollectionReference ref = FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      backgroundColor: primaryColor,
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var doc = snapshot.data.docs[index].data();
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.white,
                      onPressed: () {
                        nameController.text = doc['name'];
                        priceController.text = doc['price'];
                        stockController.text = doc['stock'];
                        descriptionController.text = doc['description'];
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    color: primaryColor,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        _buildTextField(nameController, 'Name'),
                                        SizedBox(height: 20.0),
                                        _buildTextField(
                                            priceController, 'Price'),
                                        SizedBox(height: 20.0),
                                        _buildTextField(
                                            stockController, 'Stock'),
                                        SizedBox(height: 20.0),
                                        _buildTextField(descriptionController,
                                            'Description'),
                                        SizedBox(height: 20.0),
                                        FlatButton(
                                          child: Text(
                                            'Update Product',
                                          ),
                                          color: Colors.green,
                                          onPressed: () {
                                            snapshot.data.docs[index].reference
                                                .update({
                                              "name": nameController.text,
                                              "price": priceController.text,
                                              "stock": stockController.text,
                                              "description":
                                                  descriptionController.text,
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                        SizedBox(height: 20.0),
                                        FlatButton(
                                          child: Text(
                                            'Delete Product',
                                          ),
                                          color: Colors.red,
                                          onPressed: () {
                                            snapshot.data.docs[index].reference
                                                .delete();
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                      },
                    ),
                    title: Text(
                      doc['name'],
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    subtitle: Column(
                      children: [
                        Text(
                          doc['price'],
                          style: TextStyle(color: Colors.blue),
                        ),
                        Text(
                          doc['stock'],
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          doc['description'],
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  );
                });
          } else {
            return Text('');
          }
        },
      ),
    );
  }
}
