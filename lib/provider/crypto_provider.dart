import 'dart:convert';
import 'dart:io';

import 'package:crypto_academy/data/api/api_service.dart';
import 'package:crypto_academy/data/model/final_combined_asset.dart';
import 'package:crypto_academy/data/model/get_data_response.dart';
import 'package:crypto_academy/data/model/symbol.dart';
import 'package:crypto_academy/static/CryptoResultStatic.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CryptoProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<FinalCombinedAsset> _asset = [];

  List<FinalCombinedAsset> get assets => _asset;

  CryptoResultState _resultState = CryptoResultNoneResultState();

  CryptoResultState get resultState => _resultState;

  String _getJsonString() {
    if (_asset.isEmpty) {
      return jsonEncode({"message": "Tidak ada data aset untuk diekspor."});
    } else {
      final List<Map<String, dynamic>> jsonList = _asset
          .map((asset) => asset.toJson())
          .toList();

      const JsonEncoder encoder = JsonEncoder.withIndent("   ");
      return encoder.convert(jsonList);
    }
  }

  Future<String> exportAssetsToFile() async {
    if (_asset.isEmpty) {
      return "Error: Tidak ada data aset untuk diekspor.";
    }

    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        return "Error: Izin penyimpanan ditolak. Mohon aktifkan izin di Pengaturan Aplikasi.";
      }
    }

    try {
      late Directory directory;

      if (Platform.isAndroid) {
        directory = (await getExternalStorageDirectory())!;
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getTemporaryDirectory();
      }

      final appSpecificDir = Directory('${directory.path}/MyAppExports');
      if (!await appSpecificDir.exists()) {
        await appSpecificDir.create(recursive: true);
      }

      final timestamp = DateTime.now()
          .toIso8601String()
          .substring(0, 19)
          .replaceAll(RegExp(r'[:T]'), '-');
      final fileName = "crypto_data_$timestamp.json";

      final filePath = "${appSpecificDir.path}/$fileName";
      final file = File(filePath);

      final String jsonString = _getJsonString();
      await file.writeAsString(jsonString);

      return "Sukses! Data disimpan di: $filePath";

    } catch (e) {
      return "Error saat menyimpan file: $e";
    }
  }


  Future<void> fetchCombineData() async {
    _resultState = CryptoResultLoadingResultState();
    notifyListeners();

    try {
      final listResponse = await _apiService.fetchCrypto();
      final listAssets = listResponse.result;

      final List<Future<GetDataResponse>> detailFutures = listAssets.map((
        asset,
      ) {
        return _apiService.fetchDataCrypto(asset.symbol);
      }).toList();

      final List<GetDataResponse> allDetailResponses = await Future.wait(
        detailFutures,
      );

      final Map<String, SymbolData> detailMap = {};

      for (var response in allDetailResponses) {
        if (response.symbols.isNotEmpty) {
          final SymbolData detail = response.symbols.first;
          detailMap[detail.symbol] = detail;
        }
      }
      _asset = listAssets.map((listAsset) {
        FinalCombinedAsset combinedAsset = FinalCombinedAsset.fromList(listAsset);

        if (detailMap.containsKey(listAsset.symbol)) {
          final matchedDetail = detailMap[listAsset.symbol]!;
          return combinedAsset.copyWithDetails(matchedDetail);
        }
        return combinedAsset;
      }).toList();
      _resultState = CryptoResultLoadedResultState();
    } catch (e) {
      print('Error fetching and combining data: $e');
      _resultState = CryptoResultErrorResultState(
        error: "Gagal memuat data: ${e.toString()}",
      );
    } finally {
      notifyListeners();
    }
  }
}
