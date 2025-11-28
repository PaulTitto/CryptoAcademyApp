import 'package:crypto_academy/data/model/symbol.dart';

class GetDataResponse {
  final String status;
  final List<SymbolData> symbols;

  GetDataResponse({
    required this.status,
    required this.symbols
  });

  factory GetDataResponse.fromJson(Map<String, dynamic> json){
    return GetDataResponse(
        status: json["status"],
        symbols: json["symbols"] != null
            ? List<SymbolData>.from(
            json["symbols"]!.map((x) => SymbolData.fromJson(x))) : <SymbolData>[]
    );
  }
}