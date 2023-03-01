import 'package:app_veterinaria/DTO/HeadQuartersDTO.dart';
import 'package:app_veterinaria/Model/headquarters.dart';
import 'package:app_veterinaria/Model/usuario.dart';

class LoginResult {
  final Usuario user;
  final List<HeadQuartersDTO> headquartersList;

  LoginResult({required this.user, required this.headquartersList});
}
