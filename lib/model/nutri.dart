class Nutri {
  int id;
  final int calo;
  final Duration timeCook;
  final String meal;
  final String imagenutri;
  final bool ready;
  final String howToCook;
  bool favorite;

  Nutri({
    required this.id,
    required this.calo,
    required this.timeCook,
    required this.meal,
    required this.imagenutri,
    required this.ready,
    required this.howToCook,
    required this.favorite,
  });

  factory Nutri.fromJson(Map<String, dynamic> json) {
    print('JSON Nutri: $json');  // In dữ liệu JSON của từng Nutri để kiểm tra
    return Nutri(
      id: json['id'] ?? 0,

      calo: json['calo'] ?? 0,
      timeCook: _parseDuration(json['timeCook'] ?? '00:00:00'),
      meal: json['meal'] ?? '',
      imagenutri: json['imagenutri'] ?? '',
      ready: json['ready'] ?? false,
      howToCook: json['howToCook'] ?? '',
      favorite: json['favorite'] ?? false,
    );
  }

  static Duration _parseDuration(String time) {
    List<String> parts = time.split(':');
    return Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(parts[2]),
    );
  }
}
