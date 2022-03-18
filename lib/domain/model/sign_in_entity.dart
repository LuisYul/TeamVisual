class SignInEntity {

  final String user;
  final String password;

  const SignInEntity({
    required this.user,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'user': user,
    'password': password,
  };

  Map<String, dynamic> toRequest() => {
    'txt-user': user,
    'txt-pwd': password,
  };

}