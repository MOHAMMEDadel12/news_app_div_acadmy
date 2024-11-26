class UserModel {
  String ? name;
  String  email;
  String phone;
  String image;
  String userID;

  UserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.userID,
      required this.image});

  factory UserModel.fromJson(Map<String, dynamic> json , String  ?  userID) {
    return UserModel(
        userID: userID ?? "",
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['password'],
       );
  }
}
