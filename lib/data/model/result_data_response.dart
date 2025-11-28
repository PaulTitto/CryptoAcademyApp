
class ResultDataResponse{
  final String id;
  final String symbol;
  final String name;
  final String source;
  final String ohlc_available_from;
  final String history_available_from;

  ResultDataResponse({
    required this.id,
    required this.symbol,
    required this.name,
    required this.source,
    required this.ohlc_available_from,
    required this.history_available_from,
  });

  factory ResultDataResponse.fromJson(Map<String, dynamic> json){
    return ResultDataResponse(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
        source: json["source"],
        ohlc_available_from: json["ohlc_available_from"] as String,
        history_available_from: json["history_available_from"] as String
    );
  }
}

