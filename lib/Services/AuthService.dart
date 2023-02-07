import 'package:app_veterinaria/Model/usuario.dart';
import '../DataBase/notes_database.dart';

Usuario? loggedInUser;

class Authentication {
  Future<bool> login(String email, String password) async {
    // busque os dados do usuário a partir do banco de dados
    final user = await fetchUserFromDB(email);

    user as Usuario;

    // verifique se o usuário existe e a senha está correta
    if (user != null && user.password == password) {
      // salve o usuário logado em uma variável global ou em uma sessão
      setLoggedInUser(user);
      return true;
    } else {
      return false;
    }
  }

  void setLoggedInUser(Usuario user) {
    loggedInUser = user;
    // salve o usuário logado em uma variável global ou em uma sessão
  }

  Future<Object> fetchUserFromDB(String email) async {
    final usuarioDatabase = NotesDatabase.instance;

    return await usuarioDatabase.readNote('usuario');
    // aqui você pode buscar o usuário a partir do banco de dados usando o email
    // ...
  }
}
