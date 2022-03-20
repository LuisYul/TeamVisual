class UserEntity {

  final String idUser;
  final String name;
  final String docNumber;
  final String idUserType;
  final String userType;
  final String idAssistType;
  final String photoUrl;
  final String? error;
  final String? loginStatus;

  const UserEntity({
    required this.idUser,
    required this.name,
    required this.docNumber,
    required this.idUserType,
    required this.userType,
    required this.idAssistType,
    required this.photoUrl,
    this.error,
    this.loginStatus,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
        idUser: json['idUser'],
        name: json['name'],
        docNumber: json['docNumber'],
        idUserType: json['idUserType'],
        userType: json['userType'],
        idAssistType: json['idAssistType'],
        photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'idUser': idUser,
    'name': name,
    'docNumber': docNumber,
    'idUserType': idUserType,
    'userType': userType,
    'idAssistType': idAssistType,
    'photoUrl': photoUrl,
  };

}