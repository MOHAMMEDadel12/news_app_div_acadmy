class UserModel {
  String ? name;
  String email;
  String phone;
  String image;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['password']);
  }
}
