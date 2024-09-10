class User {
  final int id;
  final String username;
  final String email;
  final int? age;
  final String? fullname;
  final String? gender;
  final double? height;
  final double? weight;
  final String? image;
  final String? level;
  final String? mobileNumber;
  final String? mucTieu;
  final String? nickname;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.age,
    this.fullname,
    this.gender,
    this.height,
    this.weight,
    this.image,
    this.level,
    this.mobileNumber,
    this.mucTieu,
    this.nickname,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0, // Giá trị mặc định nếu id null
      username: json['username'] ?? '', // Giá trị mặc định nếu username null
      email: json['email'] ?? '', // Giá trị mặc định nếu email null
      age: json['age'] != null ? json['age'] as int : null,
      fullname: json['fullname'] as String?,
      gender: json['gender'] as String?,
      height: json['height'] != null ? (json['height'] as num).toDouble() : null,
      weight: json['weight'] != null ? (json['weight'] as num).toDouble() : null,
      image: json['image'] as String?,
      level: json['level'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      mucTieu: json['mucTieu'] as String?,
      nickname: json['nickname'] as String?,
      token: json['token'] ?? '', // Giá trị mặc định nếu token null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'age': age,
      'fullname': fullname,
      'gender': gender,
      'height': height,
      'weight': weight,
      'image': image,
      'level': level,
      'mobileNumber': mobileNumber,
      'mucTieu': mucTieu,
      'nickname': nickname,
      'token': token,
    };
  }
}
