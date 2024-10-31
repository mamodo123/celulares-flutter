import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../values/consts.dart';
import 'models/phone.dart';

Future<List<Phone>> fetchPhones(String? filter) async {
  final listResponse = await http.get(Uri.parse(
      '$listUrl${filter == null ? '' : '&filter=${Uri.encodeComponent(filter)}'}'));

  if (listResponse.statusCode == 200) {
    final List<dynamic> data = jsonDecode(listResponse.body) as List<dynamic>;

    // Mapeia a lista de mapas para a lista de objetos Phone
    return data
        .map((item) => Phone.fromJson(item as Map<String, dynamic>))
        .toList();
  } else {
    return Future.error('Error in fetch data');
  }
}
