class UserDataModel {
  String? uid;
  String? name;
  String? phoneNumber;
  String? email;

  UserDataModel({this.uid, this.name, this.phoneNumber, this.email});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    name = json["name"];
    phoneNumber = json["phoneNumber"];

    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
    };
  }
}
