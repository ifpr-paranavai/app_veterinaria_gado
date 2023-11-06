import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material';
import 'package:get/get.dart';

class AuthService extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = RX<User>();
  var userIsAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();

    _firebaseUser.bindStream(_auth.authStateChanges());

    ever(_firebaseUser, (User user) {
      if (user != null) {
        userIsAuthenticated.value = true;
      } else {
        userIsAuthenticated = false;
      }
    });
  }

  User get => _firebaseUser.value;
  static AuthService get to => Get.find<AuthService>();

  showSnackBar(string titulo, String erro) {
    Get.snackbar(
      titulo,
      erro,
      backgroundColor: Colors.grey[900],
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

    } catch(e) {
      showSnackBar('Erro ao registrar! ', e.message);
    }
  }
  
}
