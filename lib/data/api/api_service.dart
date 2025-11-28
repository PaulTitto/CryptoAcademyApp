import 'dart:convert';

import 'package:crypto_academy/data/model/get_data_response.dart';
import 'package:crypto_academy/data/model/symbol.dart';

import '../model/list_data_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = "a8jdhqky81lvphd4rg1u";

  static const String baseUrl = "https://api.freecryptoapi.com/v1";

  Future<ListDataResponse> fetchCrypto() async {
    final response = await http.get(
      Uri.parse("$baseUrl/getCryptoList"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
    );

    if (response.statusCode == 200) {
      return ListDataResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<GetDataResponse> fetchDataCrypto(String symbol) async {
    // https://api.freecryptoapi.com/v1/getData?symbol=BTC
    final response = await http.get(
      Uri.parse("$baseUrl/getData?symbol=$symbol"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
    );

    if (response.statusCode == 200) {
      return GetDataResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fail to load data");
    }
  }
}
