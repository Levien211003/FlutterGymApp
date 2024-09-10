class Plan {
  int id;
  String nameplan;
  String level;
  String repeat;
  String time;
  bool favorite;
  String idyoutube;
  String imageplan;

  Plan({
    required this.id,
    required this.nameplan,
    required this.level,
    required this.repeat,
    required this.time,
    required this.favorite,
    required this.idyoutube,
    required this.imageplan,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'],
      nameplan: json['nameplan'],
      level: json['level'],
      repeat: json['repeat'],
      time: json['time'],
      favorite: json['favorite'],
      idyoutube: json['idyoutube'],
      imageplan: json['imageplan'],
    );
  }
}
