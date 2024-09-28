
class UserDataModel {
  String? uid;
  String? name;
  String? phoneNumber;
  String? email;
  String? address;
  String? myImage;

  UserDataModel({this.uid, this.name, this.phoneNumber, this.email, this.address,this.myImage});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    name = json["name"];
    phoneNumber = json["phoneNumber"];
    address = json["address"];
    email = json["email"];
    myImage = json["myImage"];
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "phoneNumber": phoneNumber,
      "email": email,
      "address":address,
      "myImage" : myImage,
    };
  }
}
