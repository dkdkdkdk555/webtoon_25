import 'package:flutter/foundation.dart';
import 'package:webtoon_25/dto/webtoon_dto.dart';
import 'package:webtoon_25/service/webtoon_model.dart';

class WebtoonListViewModel extends ChangeNotifier{
  final WebtoonModel model;
  List<WebtoonDto>? list;

  WebtoonListViewModel(this.model);

  Future<void> getWebtoonListFromModel() async{
      list = await model.getWebtoonList();
      if(list == null){
      } else {
        notifyListeners();
      }
  }
}