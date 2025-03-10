class WebtoonDto{
  final String id;
  final String title;
  final String thumb;

  WebtoonDto({
    required this.id,
    required this.title,
    required this.thumb,
  });

  // JSON → Webtoon 객체로 변환
  factory WebtoonDto.fromJson(Map<String, dynamic> json) {
    return WebtoonDto(
      id: json['id'],
      title: json['title'],
      thumb: json['thumb'],
    );
  }
}
