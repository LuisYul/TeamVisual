class UserResponse {

  String? idUser;
  String? name;
  String? docNumber;
  String? idUserType;
  String? userType;
  String? error;
  String? loginStatus;

  UserResponse({
    required this.idUser,
    required this.name,
    required this.docNumber,
    required this.idUserType,
    required this.userType,
    required this.error,
    required this.loginStatus,
  });

  factory UserResponse.fromMap(Map<String, dynamic> json) {
    return UserResponse(
      idUser: json['idUsuario'],
      name: json['nombres'],
      docNumber: json['numDoc'],
      idUserType: json['idTipoUsuario'],
      userType: json['tipoUsuario'],
      error: json['error'],
      loginStatus: json['estadoLogin'],
    );
  }

}