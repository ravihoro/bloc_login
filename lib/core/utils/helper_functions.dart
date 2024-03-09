import 'dart:convert';

import 'package:http/http.dart' as http;

Map<String, String> getHeaders() => {'Content-Type': 'application/json'};

Future<http.Response> getMethod(
  http.Client client,
  String url,
) {
  return client.get(
    Uri.parse(url),
    headers: getHeaders(),
  );
}

Future<http.Response> postMethod(
  http.Client client,
  String url,
  Map<String, dynamic> body,
) {
  return client.post(
    Uri.parse(url),
    headers: getHeaders(),
    body: jsonEncode(body),
  );
}
