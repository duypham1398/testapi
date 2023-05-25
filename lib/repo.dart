import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> getDocumentList() async {
  final response = await http.get(Uri.parse(
      "http://171.244.9.247:8083/api/Statistical/SoLuongTaiLieuTheoLoai"));
  if (response.statusCode != 200) {
    throw Exception("API error");
  }

  return jsonDecode(response.body)['Data'];
}
