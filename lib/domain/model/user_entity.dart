class UserEntity {

  final String idUser;
  final String name;
  final String docNumber;
  final String idUserType;
  final String userType;
  final String error;
  final String loginStatus;

  const UserEntity({
    required this.idUser,
    required this.name,
    required this.docNumber,
    required this.idUserType,
    required this.userType,
    required this.error,
    required this.loginStatus,
  });

}