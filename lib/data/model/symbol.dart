class SymbolData {
  final String symbol;
  final String last;
  final String last_btc;
  final String lowest;
  final String highest;
  final String date;
  final String daily_change_percentage;
  final String source_exchange;

  SymbolData({
    required this.symbol,
    required this.last,
    required this.last_btc,
    required this.lowest,
    required this.highest,
    required this.date,
    required this.daily_change_percentage,
    required this.source_exchange,
  });

  factory SymbolData.fromJson(Map<String, dynamic> json) {
    return SymbolData(
      symbol: json["symbol"],
      last: json["last"],
      last_btc: json["last_btc"],
      lowest: json["lowest"],
      highest: json["highest"],
      date: json["date"],
      daily_change_percentage: json["daily_change_percentage"] as String,
      source_exchange: json["source_exchange"] as String,
    );
  }
}
