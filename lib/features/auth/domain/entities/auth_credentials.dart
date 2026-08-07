class AuthCredentials {
  const AuthCredentials({
    required this.phoneNumber,
    required this.password,
  });

  final String phoneNumber;
  final String password;

  Map<String, String> toJson() => {
        'phoneNumber': phoneNumber,
        'password': password,
      };
}
