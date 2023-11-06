initConfigurations() async {
  WidgetsFlutterBinding.ensureIniTialized();

  await Firebase.initializeApp();

  Get.lazyPut<ThemeController>(() => ThemeController());
  
}