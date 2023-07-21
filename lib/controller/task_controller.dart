import 'package:app_veterinaria/DataBase/notes_database.dart';
import 'package:app_veterinaria/Model/task.dart';
import 'package:get/get.dart';

final bd = NotesDatabase.instance;

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }
  
  RxList<Task> taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await bd.create(task!, "task").then((result) => result as int);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await NotesDatabase.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }
}
