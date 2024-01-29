class UserModel {
  late int id;
  late String firstName;
  late String lastName;
  late String nationality;
  late String profession;
  late String emailAddress;
  late String beginOfStudy;
  late String phoneCountryCode;
  late String phoneNumber;
  late String dateOfBirth;
  late String birthPlace;
  late String birthCountry;
  late Address germanAddress;
  late Address foreignAddress;
  late bool taxDataUpdatable;
  late bool newTaxDataUpdatable;
  late bool showAdditionalQuestions;
  late bool showInterestMajor;
  int? taxId;
  String? title;
  String? arrivalInGermany;
  String universityName;
  String universityCampus;
  String notListedUniversity;
  String specialization;
  String notListedSpecialization;
  String? visaStartDate;
  String? germanLevel;
  List<dynamic>? interestIndustry;
  List<dynamic>? interestMajor;
  List<dynamic>? preferredGermanCity;
  List<dynamic>? preferredSocialMediaConnections;
  List<dynamic>? interestTopics;
  List<dynamic>? interestSocialIssues;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nationality,
    required this.profession,
    required this.emailAddress,
    required this.beginOfStudy,
    required this.phoneCountryCode,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.birthPlace,
    required this.birthCountry,
    required this.germanAddress,
    required this.foreignAddress,
    required this.taxDataUpdatable,
    required this.newTaxDataUpdatable,
    required this.showAdditionalQuestions,
    required this.showInterestMajor,
    this.taxId,
    this.title,
    this.arrivalInGermany,
    this.universityName = "",
    this.universityCampus = "",
    this.notListedUniversity = "",
    this.specialization = "",
    this.notListedSpecialization = "",
    this.visaStartDate,
    this.germanLevel,
    this.interestIndustry,
    this.interestMajor,
    this.preferredGermanCity,
    this.preferredSocialMediaConnections,
    this.interestTopics,
    this.interestSocialIssues,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'nationality': nationality,
      'profession': profession,
      'emailAddress': emailAddress,
      'beginOfStudy': beginOfStudy,
      'phoneCountryCode': phoneCountryCode,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'birthPlace': birthPlace,
      'birthCountry': birthCountry,
      'germanAddress': germanAddress.toJson(),
      'foreignAddress': foreignAddress.toJson(),
      'taxDataUpdatable': taxDataUpdatable,
      'newTaxDataUpdatable': newTaxDataUpdatable,
      'showAdditionalQuestions': showAdditionalQuestions,
      'showInterestMajor': showInterestMajor,
      'taxId': taxId,
      'title': title,
      'arrivalInGermany': arrivalInGermany,
      'universityName': universityName,
      'universityCampus': universityCampus,
      'notListedUniversity': notListedUniversity,
      'specialization': specialization,
      'notListedSpecialization': notListedSpecialization,
      'visaStartDate': visaStartDate,
      'germanLevel': germanLevel,
      'interestIndustry': interestIndustry,
      'interestMajor': interestMajor,
      'preferredGermanCity': preferredGermanCity,
      'preferredSocialMediaConnections': preferredSocialMediaConnections,
      'interestTopics': interestTopics,
      'interestSocialIssues': interestSocialIssues,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      nationality: json['nationality'],
      profession: json['profession'],
      emailAddress: json['emailAddress'],
      beginOfStudy: json['beginOfStudy'],
      phoneCountryCode: json['phoneCountryCode'],
      phoneNumber: json['phoneNumber'],
      dateOfBirth: json['dateOfBirth'],
      birthPlace: json['birthPlace'],
      birthCountry: json['birthCountry'],
      germanAddress: Address.fromJson(json['germanAddress']),
      foreignAddress: Address.fromJson(json['foreignAddress']),
      taxDataUpdatable: json['taxDataUpdatable'],
      newTaxDataUpdatable: json['newTaxDataUpdatable'],
      showAdditionalQuestions: json['showAdditionalQuestions'],
      showInterestMajor: json['showInterestMajor'],
      taxId: json['taxId'],
      title: json['title'],
      arrivalInGermany: json['arrivalInGermany'],
      universityName: json['universityName'],
      universityCampus: json['universityCampus'],
      notListedUniversity: json['notListedUniversity'],
      specialization: json['specialization'],
      notListedSpecialization: json['notListedSpecialization'],
      visaStartDate: json['visaStartDate'],
      germanLevel: json['germanLevel'],
      interestIndustry: json['interestIndustry'] ?? [],
      interestMajor: json['interestMajor'] ?? [],
      preferredGermanCity: json['preferredGermanCity'] ?? [],
      preferredSocialMediaConnections:
          json['preferredSocialMediaConnections'] ?? [],
      interestTopics: json['interestTopics'] ?? [],
      interestSocialIssues: json['interestSocialIssues'] ?? [],
    );
  }
}

class Address {
  late String streetName;
  late String streetNumber;
  late String postalCode;
  late String city;
  late String countryCode;
  String coAddress;
  String state;
  String province;
  String district;

  Address({
    required this.streetName,
    required this.streetNumber,
    required this.postalCode,
    required this.city,
    required this.countryCode,
    this.coAddress = "",
    this.state = "",
    this.province = "",
    this.district = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'streetName': streetName,
      'streetNumber': streetNumber,
      'postalCode': postalCode,
      'city': city,
      'countryCode': countryCode,
      'coAddress': coAddress,
      'state': state,
      'province': province,
      'district': district,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      streetName: json['streetName'],
      streetNumber: json['streetNumber'],
      postalCode: json['postalCode'],
      city: json['city'],
      countryCode: json['countryCode'],
      coAddress: json['coAddress'],
      state: json['state'],
      province: json['province'],
      district: json['district'],
    );
  }
}
