import 'package:dio/dio.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:dusty_dust/const/data.dart';

class StatRepository {
  static Future<List<StatModel>> fetchData({
    required ItemCode itemCode,
  }) async {
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': serviceKey,
        'returnType': 'json',
        'numOfRows': 30,
        'pageNo': 1,
        'itemCode': itemCode.name,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    return response.data['response']['body']['items']
        .map<StatModel>(
          (item) => StatModel.fromJason(json: item),
        )
        .toList();
  }
}
