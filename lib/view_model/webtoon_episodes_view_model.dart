import 'package:flutter/foundation.dart';
import 'package:webtoon_25/dto/webtoon_episode_dto.dart';
import 'package:webtoon_25/service/webtoon_model.dart';

class WebtoonEpisodeViewModel extends ChangeNotifier{
  final WebtoonModel model;
  List<WebtoonEpisodeModel>? list;

  WebtoonEpisodeViewModel(this.model);

  Future<void> getWebtoonEpisodesFromModel(String id) async{
      list = await model.getWebtoonEpisodes(id);
      if(list == null){
      } else {
        notifyListeners();
      }
  }
}