class UserEntity {

  final String idUser;
  final String name;
  final String docNumber;
  final String idUserType;
  final String userType;
  final String idAssistType;
  final String photoUrl;
  final String error;
  final String loginStatus;

  const UserEntity({
    required this.idUser,
    required this.name,
    required this.docNumber,
    required this.idUserType,
    required this.userType,
    required this.idAssistType,
    required this.photoUrl,
    required this.error,
    required this.loginStatus,
  });

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