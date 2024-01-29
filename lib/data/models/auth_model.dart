class AuthModel {
  late int userId;
  String? accessToken;
  DateTime? accessTokenExpiresAt;
  late String userRole;
  bool? xpm;
  AuthSubject? subject;
  int? maxAgeSeconds;

  AuthModel({
    required this.userId,
    this.accessToken,
    this.accessTokenExpiresAt,
    required this.userRole,
    required this.xpm,
    this.subject,
    this.maxAgeSeconds,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'accessToken': accessToken,
      'accessTokenExpiresAt': _serializeDateTime(accessTokenExpiresAt),
      'userRole': userRole,
      'xpm': xpm,
      'subject': subject?.toJson(),
      'maxAgeSeconds': maxAgeSeconds
    };
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      userId: json['userId'],
      accessToken: json['accessToken'],
      accessTokenExpiresAt: _parseServerDateTime(json['accessTokenExpiresAt']),
      userRole: json['userRole'],
      xpm: json['xpm'],
      subject: AuthSubject.fromJson(json['subject']),
      maxAgeSeconds: json['maxAgeSeconds'],
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

class AuthSubject {
  late int userId;
  String? userUuid;
  late String firstName;
  late String lastName;
  late String fullName;
  late String email;
  late String role;
  late bool isAdmin;
  List<dynamic>? consoleRoles;

  AuthSubject({
    required this.userId,
    this.userUuid,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.role,
    required this.isAdmin,
    this.consoleRoles,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userUuid': userUuid,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'role': role,
      'isAdmin': isAdmin,
      'consoleRoles': consoleRoles,
    };
  }

  factory AuthSubject.fromJson(Map<String, dynamic> json) {
    return AuthSubject(
      userId: json['userId'],
      userUuid: json['userUuid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'],
      isAdmin: json['isAdmin'] ?? false,
      consoleRoles: json['consoleRoles'] ?? [],
    );
  }
}
