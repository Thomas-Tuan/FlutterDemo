// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? idNumber;
  String? accountId;
  String? fullName;
  String? phoneNumber;
  String? imageURL;
  String? birthDay;
  String? gender;
  String? schoolYear;
  String? schoolKey;
  String? dateCreated;
  bool? status;
  String? token;

  User({
    this.idNumber,
    this.accountId,
    this.fullName,
    this.phoneNumber,
    this.imageURL,
    this.birthDay,
    this.gender,
    this.schoolYear,
    this.schoolKey,
    this.dateCreated,
    this.status,
    this.token,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNumber'] = idNumber;
    data['accountId'] = accountId;
    data['gender'] = gender;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['phoneNumber'] = phoneNumber;
    data['imageURL'] = imageURL;
    data['birthDay'] = birthDay;
    data['schoolYear'] = schoolYear;
    data['schoolKey'] = schoolKey;
    data['token'] = token;
    return data;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        idNumber: json["idNumber"],
        accountId: json["accountID"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        imageURL: json["imageURL"] == null || json["imageURL"] == ''
            ? ""
            : json['imageURL'],
        birthDay: json["birthDay"],
        gender: json["gender"],
        schoolYear: json["schoolYear"],
        schoolKey: json["schoolKey"],
        dateCreated: json["dateCreated"],
        status: json["status"],
        token: json['token'],
      );

  static User userEmpty() {
    return User(
      idNumber: '',
      accountId: '',
      fullName: '',
      phoneNumber: '',
      imageURL: '',
      birthDay: '',
      gender: '',
      schoolYear: '',
      schoolKey: '',
      dateCreated: '',
      status: false,
      token: '',
    );
  }
}
