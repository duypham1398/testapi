import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Photomodel.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  List<Photomodel> photoList = [];

  Future<List<Photomodel>> getPhotoApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode != 200) {
      throw Exception('Error');
    } else {
      for (Map i in data) {
        photoList.add(Photomodel.fromJson(i));
      }
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotoApi(),
              builder: (context, AsyncSnapshot<List<Photomodel>> snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading');
                } else {
                  return ListView.builder(
                      itemCount: photoList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                (snapshot.data![index].url ?? "").toString()),
                          ),
                          title: Text(photoList[index].title.toString()),
                          subtitle: Text(
                              snapshot.data![index].thumbnailUrl.toString()),
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
