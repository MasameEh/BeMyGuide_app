class AppLoginModel
{
  bool? status;
  late String message;
  UserDataModel? data;

  AppLoginModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDataModel.fromJson(json['data']) : null;
  }
}

class UserDataModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;
  // bool? isEmailVerified;

  UserDataModel({
    this.name,
    this.email,
    this.phone,
    this.uId,

    // this.isEmailVerified,
  });

  //named constructor
  UserDataModel.fromJson(Map<String, dynamic>? json)
  {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    // isEmailVerified = json['isEmailVerified'];
  }
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      // 'isEmailVerified':isEmailVerified,
    };
  }
}


