import 'dart:convert';
import 'dart:js_interop_unsafe';

import 'package:http/http.dart';
import '../dto/webtoon_dto.dart';

class WebtoonModel {
  final uri = Uri.parse("https://webtoon-crawler.nomadcoders.workers.dev/today");

  //웹툰 리스트 가져오기
  Future<List<WebtoonDto>> getWebtoonList() async {
    Response response = await get(uri);
    
    if(response.statusCode != 200){
      throw('Fail to api');
    }
    List<WebtoonDto> result = List.empty();
    List<Map<String, dynamic>> list = jsonDecode(response.body);
    for(Map<String,dynamic> map in list) {
      result.add(WebtoonDto.fromJson(map));
    }
    return result;
  }
}