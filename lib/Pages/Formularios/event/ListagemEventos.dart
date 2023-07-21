import 'package:app_veterinaria/Services/notification_services.dart';
import 'package:app_veterinaria/Services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListagemEventos extends StatefulWidget {
  final farm;
  const ListagemEventos({super.key, required this.farm});

  @override
  State<ListagemEventos> createState() => _ListagemEventosState();
}

class _ListagemEventosState extends State<ListagemEventos> {
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Text(
            "Theme Data",
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Dark Theme"
                  : "Activated Light Theme");

          notifyHelper.scheduledNotification();
        },
        child: Icon(
          Icons.nightlight_round,
          size: 20,
        ),
      ),
      actions: [
        Icon(
          Icons.person,
          size: 20,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
