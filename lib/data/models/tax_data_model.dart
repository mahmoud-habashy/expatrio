class TaxDataModel {
  bool? usPerson;
  int? usTaxId;
  late Tax primaryTaxResidence;
  List<Tax> secondaryTaxResidence;
  int? w9FileId;
  W9File? w9File;
  TaxDataModel({
    this.usPerson,
    this.usTaxId,
    required this.primaryTaxResidence,
    required this.secondaryTaxResidence,
    this.w9FileId,
    this.w9File,
  });

  Map<String, dynamic> toJson() {
    return {
      'usPerson': usPerson,
      'usTaxId': usTaxId,
      'primaryTaxResidence': primaryTaxResidence.toJson(),
      'secondaryTaxResidence': Tax.listToJson(secondaryTaxResidence),
      'w9FileId': w9FileId,
      'w9File': w9File?.toJson(),
    };
  }

  factory TaxDataModel.fromJson(Map<String, dynamic> json) {
    return TaxDataModel(
      usPerson: json['usPerson'],
      usTaxId: json['usTaxId'],
      primaryTaxResidence: Tax.fromJson(json['primaryTaxResidence']),
      secondaryTaxResidence: Tax.listFromJson(json['secondaryTaxResidence']),
      w9FileId: json['w9FileId'],
      w9File: W9File.fromJson(json['w9File']),
    );
  }
}

class Tax {
  late String country;
  late String id;
  Tax({required this.country, required this.id});
  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'id': id,
    };
  }

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      country: json['country'],
      id: json['id'],
    );
  }

  static List<Tax> listFromJson(List<dynamic>? taxList) {
    if (taxList == null) {
      return [];
    }
    return taxList.map((json) => Tax.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<Tax>? taxList) {
    if (taxList == null) {
      return [];
    }
    return taxList.map((Tax tax) => tax.toJson()).toList();
  }
}

class W9File {
  late int id;
  late String fileName;
  late String dataType;
  DateTime? createdAt;
  DateTime? modifiedAt;
  String? author;
  String? state;
  String? field;
  String? label;
  String? description;
  String? fileUrl;
  bool? invalid;
  W9File({
    required this.id,
    required this.fileName,
    required this.dataType,
    this.createdAt,
    this.modifiedAt,
    this.author,
    this.state,
    this.field,
    this.label,
    this.description,
    this.fileUrl,
    this.invalid,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fileName': fileName,
      'dataType': dataType,
      'createdAt': _serializeDateTime(createdAt),
      'modifiedAt': _serializeDateTime(modifiedAt),
      'author': author,
      'state': state,
      'field': field,
      'label': label,
      'description': description,
      'fileUrl': fileUrl,
      'invalid': invalid,
    };
  }

  factory W9File.fromJson(Map<String, dynamic> json) {
    return W9File(
      id: json['id'],
      fileName: json['fileName'],
      dataType: json['dataType'],
      createdAt: _parseServerDateTime(json['createdAt']),
      modifiedAt: _parseServerDateTime(json['modifiedAt']),
      author: json['author'],
      state: json['state'],
      field: json['field'],
      label: json['label'],
      description: json['description'],
      fileUrl: json['fileUrl'],
      invalid: json['invalid'],
    );
  }

  static DateTime? _parseServerDateTime(String? fromServer) {
    DateTime? result;
    if (fromServer != null) {
      result = DateTime.tryParse(fromServer)?.toLocal();
    }
    return result;
  }

  static String? _serializeDateTime(DateTime? dateTime) {
    String? result;
    if (dateTime != null) {
      result = dateTime.toString();
    }
    return result;
  }
}
