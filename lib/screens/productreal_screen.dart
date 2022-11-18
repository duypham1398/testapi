import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapi/models/product_model.dart';

class ProductrealScreen extends StatefulWidget {
  const ProductrealScreen({Key? key}) : super(key: key);

  @override
  State<ProductrealScreen> createState() => _ProductrealScreenState();
}

class _ProductrealScreenState extends State<ProductrealScreen> {
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
        title: Text('Products'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
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
                      itemCount: snapshot.data?.data?.length ?? 0,
                      itemBuilder: (context, shop) {
                        return Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    snapshot.data!.data![shop].products!.length,
                                itemBuilder: (context, products) {
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey.withOpacity(0.2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapshot.data!.data![shop]
                                                  .products![products].title
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text('  '),
                                            Text(snapshot.data!.data![shop]
                                                .products![products].description
                                                .toString())
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 150,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount: snapshot
                                                      .data!
                                                      .data![shop]
                                                      .products![products]
                                                      .images!
                                                      .length,
                                                  itemBuilder:
                                                      (context, images) {
                                                    return Container(
                                                      child: Row(
                                                        children: [
                                                          Text((snapshot
                                                                      .data!
                                                                      .data?[
                                                                          shop]
                                                                      .products?[
                                                                          products]
                                                                      .images?[
                                                                          images]
                                                                      .id ??
                                                                  "")
                                                              .toString())
                                                          // Image.network((snapshot
                                                          //             .data!
                                                          //             .data![shop]
                                                          //             .products![
                                                          //                 products]
                                                          //             .images![
                                                          //                 images]
                                                          //             .url ??
                                                          //         "")
                                                          //     .toString())
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                })
                          ],
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
