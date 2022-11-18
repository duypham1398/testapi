import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapi/models/product_model.dart';
import 'package:testapi/screens/productreal_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Future<ProductModel> getProductApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/b9409dba-9e00-4c61-81b7-defc4ee781cf'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode != 200) {
      throw Exception('Error');
    } else {
      return ProductModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shops'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModel>(
              future: getProductApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('loading');
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, shop) {
                        return Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Shop Name: '),
                                                    Text('Shop description: '),
                                                    Text('Shop mail: '),
                                                    Text('Shop address: '),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(snapshot
                                                        .data!.data![shop].name
                                                        .toString()),
                                                    Text(snapshot.data!
                                                        .data![shop].description
                                                        .toString()),
                                                    Text(snapshot.data!
                                                        .data![shop].shopemail
                                                        .toString()),
                                                    Text(snapshot.data!
                                                        .data![shop].shopaddress
                                                        .toString()),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: CircleAvatar(
                                          radius: 50.0,
                                          backgroundImage: NetworkImage(
                                              'https://media.vanityfair.com/photos/5f5156490ca7fe28f9ec3f55/master/pass/feels-good-man-film.jpg'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProductrealScreen()));
                              },
                            ),
                          ],
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
