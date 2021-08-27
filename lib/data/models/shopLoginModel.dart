class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel(this.status, this.message, this.data);

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"]?.toString();
    data = (json["data"] != null) ? UserData.fromJson(json["data"]) : null;
  }

}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData(
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  );

  UserData.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toInt();
    name = json["name"]?.toString();
    email = json["email"]?.toString();
    phone = json["phone"]?.toString();
    image = json["image"]?.toString();
    points = json["points"]?.toInt();
    credit = json["credit"]?.toInt();
    token = json["token"]?.toString();
  }
}
