import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:app_veterinaria/Services/auth_service.dart';

initConfigurations() async {
  WidgetsFlutterBinding.ensureIniTialized();

  await Firebase.initializeApp();

  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<AuthService>(() => AuthService());
}
