import 'dart:io';

class Contact {
  String? firstName;
  String? lastName;
  String? Phone;
  String? Email;
  File? img;

  Contact({
    required this.firstName,
    required this.lastName,
    required this.Phone,
    required this.Email,
    required this.img,
  });
}
