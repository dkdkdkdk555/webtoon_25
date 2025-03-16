import 'package:flutter/material.dart';
import 'package:webtoon_25/dto/webtoon_detail_dto.dart';
import 'package:webtoon_25/service/webtoon_model.dart';

class WebtoonDetailViewModel extends ChangeNotifier {
  final WebtoonModel model;
  WebtoonDetailModel? data;

  WebtoonDetailViewModel(this.model);

  Future<void> getWebtoonDetailFromModel(String id) async {
    data = await model.getWebtoonDetail(id);
    if(data == null){
    } else {
      notifyListeners();
    }
  }
}