import 'dart:convert';

import 'package:http/http.dart';
import '../dto/webtoon_dto.dart';

class WebtoonModel {
  final uri = Uri.parse("https://webtoon-crawler.nomadcoders.workers.dev/today");

  WebtoonModel();

  //웹툰 리스트 가져오기
  Future<List<WebtoonDto>> getWebtoonList() async {
    Response response = await get(uri);
    
    if(response.statusCode != 200){
      throw('Fail to api');
    }
    List<WebtoonDto> result = []; // list.empty(); 는 초기화되고 값을 추가할 수 없음.
    List<dynamic> jsonList = jsonDecode(response.body); // jsonDecode의 반환 타입은 dynamic으로 해줘야함
    List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(jsonList);
    for(Map<String,dynamic> map in list) {
      result.add(WebtoonDto.fromJson(map));
    }
    return result;
  }
}