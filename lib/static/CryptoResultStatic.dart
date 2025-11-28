
import 'package:crypto_academy/data/model/final_combined_asset.dart';

sealed class CryptoResultState {}

class CryptoResultNoneResultState extends CryptoResultState{}
class CryptoResultLoadingResultState extends CryptoResultState{}
class CryptoResultErrorResultState extends CryptoResultState{
  final String error;
  CryptoResultErrorResultState({
    required this.error
});
}
class CryptoResultLoadedResultState extends CryptoResultState{}
