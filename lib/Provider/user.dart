import 'package:flutter/material.dart';
import 'package:offiql/Db/base.dart';
import 'package:offiql/Models/local_user.dart';

import '../Helper/showSnackbar.dart';

class UserProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final contactPattern = r'^\+91\d{10}$';

  bool? isCorrectContact;
  bool? isCorrectEmail;
  bool isSubmitting = false;

  void validateEmail(String value) {
    isCorrectEmail = RegExp(emailPattern).hasMatch(value);
    notifyListeners();
  }

  void validateContact(String value) {
    isCorrectContact = RegExp(contactPattern).hasMatch(value);
    notifyListeners();
  }

  Future<void> handleSubmit(BuildContext context) async {
    if (isSubmitting) return;

    if (nameController.text.isEmpty ||
        contactController.text.isEmpty ||
        emailController.text.isEmpty) {
      showSnackBar("Please fill all the details", context,
          bgColor: Colors.red.shade300);
      return;
    }

    if (!RegExp(contactPattern).hasMatch(contactController.text)) {
      showSnackBar(
          "Invalid contact number, please enter a valid contact number",
          context,
          bgColor: Colors.red.shade300);
      return;
    }
    if (!RegExp(emailPattern).hasMatch(emailController.text)) {
      showSnackBar(
          "Invalid Email Address, please enter a valid Email Address", context,
          bgColor: Colors.red.shade300);
      return;
    }
    try {
      isSubmitting = true;
      notifyListeners();

      await DbHelper().insertUser(LocalUserModel(
          email: emailController.text,
          name: nameController.text,
          phone: contactController.text));
      showSnackBar("Your details have been added successfully!", context,
          bgColor: Colors.deepPurpleAccent.shade200);

      nameController.clear();
      contactController.clear();
      emailController.clear();
    } catch (e) {
      showSnackBar("Something went wrong, Please try again.", context);
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
