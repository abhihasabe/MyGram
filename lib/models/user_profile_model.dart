class UserProfileModel {
  String status;
  String message;
  User user;

  UserProfileModel({this.status, this.message, this.user});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String id;
  String uniqueId;
  String userId;
  String token;
  String villageCode;
  String firstName;
  String lastName;
  String middleName;
  String email;
  String phoneNumber;
  String pincode;
  String village;
  String status;
  String role;
  int createdDate;
  Null updatedDate;
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String bloodGroup;
  String gender;
  String profession;
  Null photoURL;
  bool admin;

  User(
      {this.id,
        this.uniqueId,
        this.userId,
        this.token,
        this.villageCode,
        this.firstName,
        this.lastName,
        this.middleName,
        this.email,
        this.phoneNumber,
        this.pincode,
        this.village,
        this.status,
        this.role,
        this.createdDate,
        this.updatedDate,
        this.addressLine1,
        this.addressLine2,
        this.addressLine3,
        this.bloodGroup,
        this.gender,
        this.profession,
        this.photoURL,
        this.admin});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['uniqueId'];
    userId = json['userId'];
    token = json['token'];
    villageCode = json['villageCode'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    pincode = json['pincode'];
    village = json['village'];
    status = json['status'];
    role = json['role'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    addressLine3 = json['addressLine3'];
    bloodGroup = json['bloodGroup'];
    gender = json['gender'];
    profession = json['profession'];
    photoURL = json['photoURL'];
    admin = json['admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uniqueId'] = this.uniqueId;
    data['userId'] = this.userId;
    data['token'] = this.token;
    data['villageCode'] = this.villageCode;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['pincode'] = this.pincode;
    data['village'] = this.village;
    data['status'] = this.status;
    data['role'] = this.role;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['addressLine3'] = this.addressLine3;
    data['bloodGroup'] = this.bloodGroup;
    data['gender'] = this.gender;
    data['profession'] = this.profession;
    data['photoURL'] = this.photoURL;
    data['admin'] = this.admin;
    return data;
  }
}