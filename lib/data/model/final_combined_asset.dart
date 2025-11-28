import 'package:crypto_academy/data/model/result_data_response.dart';
import 'package:crypto_academy/data/model/symbol.dart';

class FinalCombinedAsset {
  //   From APi List
  final String id;
  final String symbol;
  final String name;
  final String source;
  final String ohlc_available_from;
  final String history_available_from;

  //   From Api GetData
  final String? last;
  final String? last_btc;
  final String? lowest;
  final String? highest;
  final String? date;
  final String? daily_change_precentage;
  final String? source_exchange;

  FinalCombinedAsset({
    required this.id,
    required this.symbol,
    required this.name,
    required this.source,
    required this.ohlc_available_from,
    required this.history_available_from,
    this.last,
    this.last_btc,
    this.lowest,
    this.highest,
    this.date,
    this.daily_change_precentage,
    this.source_exchange,
  });

  factory FinalCombinedAsset.fromList(ResultDataResponse listData) {
    return FinalCombinedAsset(
      id: listData.id,
      symbol: listData.symbol,
      name: listData.name,
      source: listData.source,
      ohlc_available_from: listData.ohlc_available_from,
      history_available_from: listData.history_available_from,
    );
  }

  FinalCombinedAsset copyWithDetails(SymbolData detail) {
    return FinalCombinedAsset(
      id: this.id,
      symbol: this.symbol,
      name: this.name,
      source: this.source,
      ohlc_available_from: this.ohlc_available_from,
      history_available_from: this.history_available_from,
      last: detail.last,
      last_btc: detail.last_btc,
      lowest: detail.lowest,
      highest: detail.highest,
      date: detail.date,
      daily_change_precentage: detail.daily_change_percentage,
      source_exchange: detail.source_exchange,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id":id,
      "symbol":symbol,
      "name":name,
      "source":source,
      "ohlc_available_from":ohlc_available_from,
      "history_available_from":history_available_from,
      "last":last,
      "last_btc":last_btc,
      "lowest":lowest,
      "highest":highest,
      "date":date,
      "daily_change_precentage":daily_change_precentage,
      "source_exchange":source_exchange,
    };
}
}
