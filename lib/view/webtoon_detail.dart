import 'package:flutter/material.dart';
import 'package:webtoon_25/service/webtoon_model.dart';
import 'package:webtoon_25/view_model/webtoon_episodes_view_model.dart';
import 'package:webtoon_25/view_model/webtton_detail_view_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebtoonDetail extends StatefulWidget {
  final String id;
  final String title;
  final String thumb;

  const WebtoonDetail({super.key, required this.id, required this.title, required this.thumb});

  @override
  State<WebtoonDetail> createState() => _WebtoonDetailState();
}

class _WebtoonDetailState extends State<WebtoonDetail> {
  final webtoonDetail = WebtoonDetailViewModel(WebtoonModel());
  final webtoonEpisodes = WebtoonEpisodeViewModel(WebtoonModel());

  @override
  void initState(){
    super.initState();
    _loadWebtoonDetail();
    _loadWebtoonEpisodes();
  }

  Future<void> _loadWebtoonDetail() async {
    await webtoonDetail.getWebtoonDetailFromModel(widget.id);
  }
  Future<void> _loadWebtoonEpisodes() async {
    await webtoonEpisodes.getWebtoonEpisodesFromModel(widget.id);
  }

  onButtonTap(String epid)async{
    await launchUrlString("https://comic.naver.com/webtoon/detail?titleId=${widget.id}&no=$epid");
  }
  var appbarColor =  const Color.fromARGB(255, 64, 162, 64);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailViewAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListenableBuilder(
                listenable: webtoonDetail,
                builder: (context, child) {

                  if(webtoonDetail.data == null){
                    return const Center(child: CircularProgressIndicator()); 
                  }

                  var webtoon = webtoonDetail.data!;
              
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.thumb,
                          width: 230,
                          headers: const {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
                        child: Text(
                          webtoon.about,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600
                          ),   
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 55),
                        child: Text(
                          textAlign: TextAlign.start,
                          "${webtoon.genre}/ ${webtoon.age}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500
                          ),   
                        ),
                      ),
                    ],
                  );
                }
              ),
            ListenableBuilder(
              listenable: webtoonEpisodes,
              builder: (context, child) {

                if(webtoonEpisodes.list == null || webtoonEpisodes.list!.isEmpty){
                    return const Center(child: CircularProgressIndicator()); 
                }
                  
                return ListView.builder(
                    shrinkWrap: true, // ✅ ListView가 내용만큼만 높이를 차지하도록 설정
                    physics: const NeverScrollableScrollPhysics(), // ✅ SingleChildScrollView 안에서 스크롤 중복 방지
                    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 20),
                    scrollDirection: Axis.vertical,
                    itemCount: webtoonEpisodes.list!.length,
                    itemBuilder: (context, idx){
                      var episode = webtoonEpisodes.list![idx];
                      return GestureDetector(
                        onTap :  () => onButtonTap(episode.id),
                        child: Container(
                          height: 35,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            color: appbarColor
                            
                          ),
                          child: Text(
                            textAlign: TextAlign.start,
                        
                            episode.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                          ),
                        ),
                      );
                    },
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  // 
  // 상단바
  AppBar detailViewAppbar(context){
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: appbarColor,
        ), // 기본 백버튼의 아이콘 변경
        onPressed: () {
          Navigator.pop(context); // 뒤로 가기 기능 유지
        },
      ),
      title: Text(
          widget.title,
          style: TextStyle(
            color: appbarColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            icon: Icon(
              Icons.favorite_border_outlined,
              color: appbarColor,
            ), // 오른쪽 아이콘 추가
            onPressed: () {
              // 좋아요 버튼 클릭 이벤트 추가 가능
            },
          ),
        ),
     ],
    );
  }
}