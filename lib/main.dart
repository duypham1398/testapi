import 'package:flutter/material.dart';
import 'package:testapi/repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestAPI(),
    );
  }
}

class TestAPI extends StatefulWidget {
  const TestAPI({Key? key}) : super(key: key);

  @override
  State<TestAPI> createState() => _TestAPIState();
}

class _TestAPIState extends State<TestAPI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: getDocumentList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var name = snapshot.data![index]['TypeBookName'];
                    var total = snapshot.data![index]['TongSo'].toString();
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.green.shade300,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        leading: Text(name),
                        title: Text(total),
                      ),
                    );
                  },
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
