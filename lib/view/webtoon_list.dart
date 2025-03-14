import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webtoon_25/service/webtoon_model.dart';
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
    _loadWebtoonList(); // 뷰가 초기화 될때 호출
  }

  Future<void> _loadWebtoonList() async {
    await webtoonListViewModel.getWebtoonListFromModel();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: webtoonListViewModel, 
      builder: (context, child) {
         if (webtoonListViewModel.list == null || webtoonListViewModel.list!.isEmpty) {
          return const Center(child: CircularProgressIndicator()); // ✅ 로딩 UI 추가
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: webtoonListViewModel.list!.length,
                itemBuilder: (context, idx){
                  var webtoon = webtoonListViewModel.list![idx];
                  return Column(
                    children: [
                      Image.network(
                          webtoon.thumb,
                          headers: const { 
                            // 밑에는 안드로이드 나 IOS 를 에뮬레이터를 사용할 경우 CORS 문제를 해결하기 위해 넣어야 하는 헤더 내용이다.
                            // 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                            // 'Referer': 'https://comic.naver.com',
                      
                            // chrome 에서 할때는 
                            // flutter run -d chrome --web-renderer html
                            // 명령어로 실행하여 해결함. HTML 랜더링 엔진을 사용하도록 설정하는 것
                          },
                        ),
                      Text(
                        webtoon.title
                      ),
                    ],
                  );
                }
              ),
            )
          ],
        );
      }
    );
  }
}