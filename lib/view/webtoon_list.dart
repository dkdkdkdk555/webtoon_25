import 'package:flutter/material.dart';
import 'package:webtoon_25/service/webtoon_model.dart';
import 'package:webtoon_25/view/webtoon_detail.dart';
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
          return const Center(child: CircularProgressIndicator()); 
        }
        return Expanded(
          child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: webtoonListViewModel.list!.length,
                    padding: const EdgeInsets.only(top:30, left: 40),
                    itemBuilder: (context, idx){
                      var webtoon = webtoonListViewModel.list![idx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push( 
                              context, 
                              MaterialPageRoute(builder: (context) => WebtoonDetail(id: webtoon.id, title: webtoon.title, thumb: webtoon.thumb,))
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                      webtoon.thumb,
                                      width: 230,
                                      headers: const { 
                                        // 밑에는 안드로이드 나 IOS 를 에뮬레이터를 사용할 경우 CORS 문제를 해결하기 위해 넣어야 하는 헤더 내용이다.
                                        // 'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                                        // 'Referer': 'https://comic.naver.com',
                                  
                                        // chrome 에서 할때는 
                                        // flutter run -d chrome --web-renderer html
                                        // 명령어로 실행하여 해결함. HTML 랜더링 엔진을 사용하도록 설정하는 것
                                      },
                                    ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  webtoon.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600
                                  ),                   
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                  }
            ),
        );
      }
    );
  }
}