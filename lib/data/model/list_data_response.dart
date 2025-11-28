import 'package:crypto_academy/data/model/result_data_response.dart';

class ListDataResponse {
  final bool status;
  final int resultset_size;
  final List<ResultDataResponse> result;


  ListDataResponse({
    required this.status,
    required this.resultset_size,
    required this.result
  });

  factory ListDataResponse.fromJson(Map<String, dynamic> json){
    return ListDataResponse(
        status: json["status"],
        resultset_size: json["resultset_size"],
        result: json["result"] != null
            ? List<ResultDataResponse>.from(
            json["result"].map((x) => ResultDataResponse.fromJson(x)))
            : <ResultDataResponse>[]
    );
  }


}


