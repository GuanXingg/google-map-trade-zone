import 'dart:convert';

import 'package:xml2json/xml2json.dart';

Map<String, dynamic> parseKml2Json(String xmlString) {
  final Xml2Json xml2json = Xml2Json();

  xml2json.parse(xmlString);
  final String jsonString = xml2json.toParker();
  final Map<String, dynamic> json = jsonDecode(jsonString);

  return json;
}
