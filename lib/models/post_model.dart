class PostModel {
  String status;
  String message;
  List<AlertWithUsers> alertWithUsers;

  PostModel({this.status, this.message, this.alertWithUsers});

  PostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['alertWithUsers'] != null) {
      alertWithUsers = new List<AlertWithUsers>();
      json['alertWithUsers'].forEach((v) {
        alertWithUsers.add(new AlertWithUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.alertWithUsers != null) {
      data['alertWithUsers'] =
          this.alertWithUsers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AlertWithUsers {
  Alert alert;
  User user;

  AlertWithUsers({this.alert, this.user});

  AlertWithUsers.fromJson(Map<String, dynamic> json) {
    alert = json['alert'] != null ? new Alert.fromJson(json['alert']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alert != null) {
      data['alert'] = this.alert.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Alert {
  String id;
  String alertId;
  String title;
  String description;
  String photoURL;
  String mediaURL;
  String status;
  int createdDate;
  String userId;
  String villageCode;
  String category;
  Null updatedDate;

  Alert(
      {this.id,
        this.alertId,
        this.title,
        this.description,
        this.photoURL,
        this.mediaURL,
        this.status,
        this.createdDate,
        this.userId,
        this.villageCode,
        this.category,
        this.updatedDate});

  Alert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    alertId = json['alertId'];
    title = json['title'];
    description = json['description'];
    photoURL = json['photoURL'];
    mediaURL = json['mediaURL'];
    status = json['status'];
    createdDate = json['createdDate'];
    userId = json['userId'];
    villageCode = json['villageCode'];
    category = json['category'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['alertId'] = this.alertId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['photoURL'] = this.photoURL;
    data['mediaURL'] = this.mediaURL;
    data['status'] = this.status;
    data['createdDate'] = this.createdDate;
    data['userId'] = this.userId;
    data['villageCode'] = this.villageCode;
    data['category'] = this.category;
    data['updatedDate'] = this.updatedDate;
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