import 'package:flutter/material.dart';
import 'package:webtoon_25/model/webtoon_model.dart';
import 'package:webtoon_25/view_model/webtoon_list_view_model.dart';

class WebtoonList extends StatefulWidget {
  const WebtoonList({super.key});

  @override
  State<WebtoonList> createState() => _WebtoonListState();
}

class _WebtoonListState extends State<WebtoonList> {
  final webtoonListViewModel = WebtoonListViewModel(WebtoonModel());

  @override
  void initState() {
    super.initState();
    _loadWebtoonList();
  }

  Future<void> _loadWebtoonList() async {
    await webtoonListViewModel.getWebtoonListFromModel(); // ✅ 데이터 로드
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: webtoonListViewModel, 
      builder: (context, child) {
         if (webtoonListViewModel.list == null || webtoonListViewModel.list!.isEmpty) {
          return const Center(child: CircularProgressIndicator()); // ✅ 로딩 UI 추가
        }

        return Text(webtoonListViewModel.list![0].title); // ✅ null이 아닐 때만 접근
      }
    );
  }
}