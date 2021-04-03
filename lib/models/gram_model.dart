class GramModel {
  MainGramPanchayat mainGramPanchayat;
  String message;
  String status;

  GramModel({this.mainGramPanchayat, this.message, this.status});

  GramModel.fromJson(Map<String, dynamic> json) {
    mainGramPanchayat = json['mainGramPanchayat'] != null
        ? new MainGramPanchayat.fromJson(json['mainGramPanchayat'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mainGramPanchayat != null) {
      data['mainGramPanchayat'] = this.mainGramPanchayat.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class MainGramPanchayat {
  String createdBy;
  String createdDate;
  String district;
  List<GovtRepresentativeList> govtRepresentativeList;
  GramFund gramFund;
  List<GramMemberList> gramMemberList;
  List<GramNoticeList> gramNoticeList;
  List<GramWorkList> gramWorkList;
  String id;
  int literacy;
  int men;
  String name;
  String pincode;
  int population;
  SarpanchDetails sarpanchDetails;
  List<String> schoolNames;
  String state;
  String status;
  String taluka;
  String updatedDate;
  String village;
  String villageCode;
  int women;

  MainGramPanchayat(
      {this.createdBy,
        this.createdDate,
        this.district,
        this.govtRepresentativeList,
        this.gramFund,
        this.gramMemberList,
        this.gramNoticeList,
        this.gramWorkList,
        this.id,
        this.literacy,
        this.men,
        this.name,
        this.pincode,
        this.population,
        this.sarpanchDetails,
        this.schoolNames,
        this.state,
        this.status,
        this.taluka,
        this.updatedDate,
        this.village,
        this.villageCode,
        this.women});

  MainGramPanchayat.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    district = json['district'];
    if (json['govtRepresentativeList'] != null) {
      govtRepresentativeList = new List<GovtRepresentativeList>();
      json['govtRepresentativeList'].forEach((v) {
        govtRepresentativeList.add(new GovtRepresentativeList.fromJson(v));
      });
    }
    gramFund = json['gramFund'] != null
        ? new GramFund.fromJson(json['gramFund'])
        : null;
    if (json['gramMemberList'] != null) {
      gramMemberList = new List<GramMemberList>();
      json['gramMemberList'].forEach((v) {
        gramMemberList.add(new GramMemberList.fromJson(v));
      });
    }
    if (json['gramNoticeList'] != null) {
      gramNoticeList = new List<GramNoticeList>();
      json['gramNoticeList'].forEach((v) {
        gramNoticeList.add(new GramNoticeList.fromJson(v));
      });
    }
    if (json['gramWorkList'] != null) {
      gramWorkList = new List<GramWorkList>();
      json['gramWorkList'].forEach((v) {
        gramWorkList.add(new GramWorkList.fromJson(v));
      });
    }
    id = json['id'];
    literacy = json['literacy'];
    men = json['men'];
    name = json['name'];
    pincode = json['pincode'];
    population = json['population'];
    sarpanchDetails = json['sarpanchDetails'] != null
        ? new SarpanchDetails.fromJson(json['sarpanchDetails'])
        : null;
    schoolNames = json['schoolNames'].cast<String>();
    state = json['state'];
    status = json['status'];
    taluka = json['taluka'];
    updatedDate = json['updatedDate'];
    village = json['village'];
    villageCode = json['villageCode'];
    women = json['women'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['district'] = this.district;
    if (this.govtRepresentativeList != null) {
      data['govtRepresentativeList'] =
          this.govtRepresentativeList.map((v) => v.toJson()).toList();
    }
    if (this.gramFund != null) {
      data['gramFund'] = this.gramFund.toJson();
    }
    if (this.gramMemberList != null) {
      data['gramMemberList'] =
          this.gramMemberList.map((v) => v.toJson()).toList();
    }
    if (this.gramNoticeList != null) {
      data['gramNoticeList'] =
          this.gramNoticeList.map((v) => v.toJson()).toList();
    }
    if (this.gramWorkList != null) {
      data['gramWorkList'] = this.gramWorkList.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['literacy'] = this.literacy;
    data['men'] = this.men;
    data['name'] = this.name;
    data['pincode'] = this.pincode;
    data['population'] = this.population;
    if (this.sarpanchDetails != null) {
      data['sarpanchDetails'] = this.sarpanchDetails.toJson();
    }
    data['schoolNames'] = this.schoolNames;
    data['state'] = this.state;
    data['status'] = this.status;
    data['taluka'] = this.taluka;
    data['updatedDate'] = this.updatedDate;
    data['village'] = this.village;
    data['villageCode'] = this.villageCode;
    data['women'] = this.women;
    return data;
  }
}

class GovtRepresentativeList {
  String department;
  String name;
  String phoneNumber;
  String role;

  GovtRepresentativeList(
      {this.department, this.name, this.phoneNumber, this.role});

  GovtRepresentativeList.fromJson(Map<String, dynamic> json) {
    department = json['department'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['department'] = this.department;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['role'] = this.role;
    return data;
  }
}

class GramFund {
  int approvedFund;
  int approvedTaxFund;
  int availableFund;
  List<String> files;
  int spentFund;

  GramFund(
      {this.approvedFund,
        this.approvedTaxFund,
        this.availableFund,
        this.files,
        this.spentFund});

  GramFund.fromJson(Map<String, dynamic> json) {
    approvedFund = json['approvedFund'];
    approvedTaxFund = json['approvedTaxFund'];
    availableFund = json['availableFund'];
    files = json['files'].cast<String>();
    spentFund = json['spentFund'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approvedFund'] = this.approvedFund;
    data['approvedTaxFund'] = this.approvedTaxFund;
    data['availableFund'] = this.availableFund;
    data['files'] = this.files;
    data['spentFund'] = this.spentFund;
    return data;
  }
}

class GramMemberList {
  String department;
  String name;
  String phoneNumber;
  String photoURL;
  String ward;

  GramMemberList(
      {this.department, this.name, this.phoneNumber, this.photoURL, this.ward});

  GramMemberList.fromJson(Map<String, dynamic> json) {
    department = json['department'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    photoURL = json['photoURL'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['department'] = this.department;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['photoURL'] = this.photoURL;
    data['ward'] = this.ward;
    return data;
  }
}

class GramNoticeList {
  List<String> files;
  String owner;
  String subject;

  GramNoticeList({this.files, this.owner, this.subject});

  GramNoticeList.fromJson(Map<String, dynamic> json) {
    files = json['files'].cast<String>();
    owner = json['owner'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['files'] = this.files;
    data['owner'] = this.owner;
    data['subject'] = this.subject;
    return data;
  }
}

class GramWorkList {
  List<String> afterPhotos;
  String approvalDate;
  String approxCompletionDate;
  int approxCost;
  String approxStartDate;
  List<String> beforePhotos;
  String contractorName;
  String contractorNumber;
  int cost;
  String endDate;
  String place;
  String startDate;
  String status;
  String workDetails;
  String workName;

  GramWorkList(
      {this.afterPhotos,
        this.approvalDate,
        this.approxCompletionDate,
        this.approxCost,
        this.approxStartDate,
        this.beforePhotos,
        this.contractorName,
        this.contractorNumber,
        this.cost,
        this.endDate,
        this.place,
        this.startDate,
        this.status,
        this.workDetails,
        this.workName});

  GramWorkList.fromJson(Map<String, dynamic> json) {
    afterPhotos = json['afterPhotos'].cast<String>();
    approvalDate = json['approvalDate'];
    approxCompletionDate = json['approxCompletionDate'];
    approxCost = json['approxCost'];
    approxStartDate = json['approxStartDate'];
    beforePhotos = json['beforePhotos'].cast<String>();
    contractorName = json['contractorName'];
    contractorNumber = json['contractorNumber'];
    cost = json['cost'];
    endDate = json['endDate'];
    place = json['place'];
    startDate = json['startDate'];
    status = json['status'];
    workDetails = json['workDetails'];
    workName = json['workName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['afterPhotos'] = this.afterPhotos;
    data['approvalDate'] = this.approvalDate;
    data['approxCompletionDate'] = this.approxCompletionDate;
    data['approxCost'] = this.approxCost;
    data['approxStartDate'] = this.approxStartDate;
    data['beforePhotos'] = this.beforePhotos;
    data['contractorName'] = this.contractorName;
    data['contractorNumber'] = this.contractorNumber;
    data['cost'] = this.cost;
    data['endDate'] = this.endDate;
    data['place'] = this.place;
    data['startDate'] = this.startDate;
    data['status'] = this.status;
    data['workDetails'] = this.workDetails;
    data['workName'] = this.workName;
    return data;
  }
}

class SarpanchDetails {
  String name;
  String phoneNumber;
  String photoURL;
  String qualification;

  SarpanchDetails(
      {this.name, this.phoneNumber, this.photoURL, this.qualification});

  SarpanchDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    photoURL = json['photoURL'];
    qualification = json['qualification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['photoURL'] = this.photoURL;
    data['qualification'] = this.qualification;
    return data;
  }
}