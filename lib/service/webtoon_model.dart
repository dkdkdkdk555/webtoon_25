import 'dart:convert';

import 'package:http/http.dart';
import 'package:webtoon_25/dto/webtoon_detail_dto.dart';
import 'package:webtoon_25/dto/webtoon_episode_dto.dart';
import '../dto/webtoon_dto.dart';

class WebtoonModel {
  String url = "https://webtoon-crawler.nomadcoders.workers.dev";

  WebtoonModel();

  //웹툰 리스트 가져오기
  Future<List<WebtoonDto>> getWebtoonList() async {
    final uri = Uri.parse("$url/today");
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

  //웹툰 상세 가져오기
  Future<WebtoonDetailModel> getWebtoonDetail(String id) async {
    final uri = Uri.parse("$url/$id");
    Response response = await get(uri);

    if(response.statusCode != 200){
      throw('Fail to api');
    }
    dynamic jsonResult = jsonDecode(response.body);
    Map<String, dynamic> map = Map<String, dynamic>.from(jsonResult);
    WebtoonDetailModel webtoonDetail = WebtoonDetailModel.fromJson(map);
    return webtoonDetail;
  }

  //웹툰 에피소드 가져오기
  Future<List<WebtoonEpisodeModel>> getWebtoonEpisodes(String id) async {
    final uri = Uri.parse("$url/$id/episodes");
    Response response = await get(uri);

    if(response.statusCode != 200){
      throw('Fail to api');
    }

    List<WebtoonEpisodeModel> result = []; // list.empty(); 는 초기화되고 값을 추가할 수 없음.
    List<dynamic> jsonList = jsonDecode(response.body); // jsonDecode의 반환 타입은 dynamic으로 해줘야함
    List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(jsonList);
    for(Map<String,dynamic> map in list) {
      result.add(WebtoonEpisodeModel.fromJson(map));
    }
    return result;
  }
}