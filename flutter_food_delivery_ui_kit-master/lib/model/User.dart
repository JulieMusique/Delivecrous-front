class User {
  String firstName;
  String lastName;
  String email;
  String address;
  String phoneNumber;
  String password;
  final String photoUrl;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.photoUrl,
    required this.password
  });
}
