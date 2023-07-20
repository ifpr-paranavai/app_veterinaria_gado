import 'package:app_veterinaria/DTO/HeadQuartersDTO.dart';
import 'package:app_veterinaria/Model/breed.dart';
import 'package:app_veterinaria/Model/gado.dart';
import 'package:app_veterinaria/Model/headquarters.dart';
import 'package:app_veterinaria/Model/historico.dart';
import 'package:app_veterinaria/Model/note.dart';
import 'package:app_veterinaria/Model/pesagem.dart';
import 'package:app_veterinaria/Model/usuario.dart';
import 'package:app_veterinaria/Model/usuarioHeadquarters.dart';
import 'package:app_veterinaria/Model/vacina.dart';
import 'package:app_veterinaria/Services/LoginResult.dart';
import '../Model/breed.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  //global instance of the database
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  String? user;

  //private constructor
  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // apaga os dados quando o app é iniciado
    await deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';
    final dateType = 'DATE NOT NULL';
    final nullIntType = 'INTEGER';
    final nulltextType = 'TEXT';
    final nulldateType = 'DATE';
    final nullboolType = 'BOOLEAN';
    final nullfloatType = 'FLOAT';

    await db.execute('''
CREATE TABLE $tableNotes(
  ${NoteFields.id} $idType,
  ${NoteFields.isImportant} $boolType,
  ${NoteFields.number} $intType,
  ${NoteFields.title} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType
)
''');

    await db.execute('''
CREATE TABLE $tableGado(
  ${GadoFields.id} $idType,
  ${GadoFields.nome} $nulltextType,
  ${GadoFields.numero} $nulltextType,
  ${GadoFields.dataNascimento} $nulltextType,
  ${GadoFields.dataBaixa} $nulldateType,
  ${GadoFields.motivoBaixa} $textType,
  ${GadoFields.partosNaoLancados} $nulltextType,
  ${GadoFields.partosTotais} $nulltextType,
  ${GadoFields.lote} $nulltextType,
  ${GadoFields.nomeMae} $nulltextType,
  ${GadoFields.nomePai} $nulltextType,
  ${GadoFields.numeroMae} $nulltextType,
  ${GadoFields.numeroPai} $nulltextType,
  ${GadoFields.breedId} $nullIntType,
  ${GadoFields.farmId} $nullIntType
  )
''');

    await db.execute('''
CREATE TABLE $tableUsuario(
  ${UsuarioFields.id} $idType,
  ${UsuarioFields.name} $textType,
  ${UsuarioFields.email} $textType,
  ${UsuarioFields.password} $textType
  )
''');

    await db.execute('''
CREATE TABLE $tableBreed(
  ${BreedFields.id} $idType,
  ${BreedFields.name} $textType,
  ${BreedFields.farmId} $nullIntType
)''');

    await db.execute('''
CREATE TABLE $tableheadquarters(
  ${HeadquartersFields.id} $idType,
  ${HeadquartersFields.idUsuario} $nullIntType,
  ${HeadquartersFields.name} $textType,
  ${HeadquartersFields.number} $textType,
  ${HeadquartersFields.observacao} $nulltextType,
  ${HeadquartersFields.cpfCnpj} $nulltextType
)
''');

    await db.execute('''
  CREATE TABLE $tablePesagem(
    ${PesagemFields.id} $idType,
    ${PesagemFields.anotacao} $nulltextType,
    ${PesagemFields.dataPesagem} $nulldateType,
    ${PesagemFields.gadoId} $intType,
    ${PesagemFields.peso} $nullfloatType
  )
''');

    await db.execute('''
  CREATE TABLE $tablehistorico(
    ${HistoricoFields.id} $idType,
    ${HistoricoFields.descricao} $nulltextType,
    ${HistoricoFields.diaOcorrencia} $nulldateType,
    ${HistoricoFields.idAnimal} $intType,
    ${HistoricoFields.tipo} $intType

  )
''');

    await db.execute('''
  CREATE TABLE $tablevacina(
    ${VacinaFields.id} $idType,
    ${VacinaFields.nome} $nulltextType,
    ${VacinaFields.observacao} $nulltextType,
    ${VacinaFields.dataAplicacao} $nulldateType,
    ${VacinaFields.idAnimal} $intType,
    ${VacinaFields.responsavel} $nulltextType,
    ${VacinaFields.localAplicacao} $nulltextType,
    ${VacinaFields.numeroLote} $nulltextType,
    ${VacinaFields.validade} $nulldateType,
    ${VacinaFields.dosagem} $nullfloatType
  )
''');

    await db.execute('''
CREATE TABLE $tableUsuarioHeadquarters(
  id $idType,
  userId $intType,
  headquarterId $intType
)
''');

    await db.execute('''
INSERT INTO $tableUsuario (name, email, password) VALUES ('ADMIN', 'admin@gmail.com', 'admin123')
''');
    await db.execute(
        '''INSERT INTO $tableheadquarters (name, number, observacao, cpfCnpj, idUsuario) VALUES ('Fazenda 1', '123456789', 'Observação', '123456789', '1')
''');
    await db.execute('''
INSERT INTO $tableUsuarioHeadquarters (userId, headquarterId) VALUES ('1', '1')
''');
  }

  Future<Object> create(Object object, String tableName) async {
    try {
      final db = await instance.database;

      if (tableName == 'gado') {
        Gado gado = object as Gado;
        var id;
        if (gado.id != null) {
          id = await db.update(tableGado, gado.toJson(),
              where: '${GadoFields.id} = ?', whereArgs: [gado.id]);
        } else {
          id = await db.insert(tableGado, gado.toJson());
        }
        return gado.copy(id: id);
      } else if (tableName == 'usuario') {
        Usuario usuario = object as Usuario;
        var id;
        if (usuario.id != null) {
          id = await db.update(tableUsuario, usuario.toJson(),
              where: '${UsuarioFields.id} = ?', whereArgs: [usuario.id]);
        } else {
          id = await db.insert(tableUsuario, usuario.toJson());
        }
        return usuario.copy(id: id);
      } else if (tableName == "breed") {
        var id;
        Breed breed = object as Breed;
        if (breed.id != null) {
          id = await db.update(tableBreed, breed.toJson(),
              where: '${BreedFields.id} = ?', whereArgs: [breed.id]);
        } else {
          id = await db.insert(tableBreed, breed.toJson());
        }
        return breed.copy(id: id);
      } else if (tableName == "headquarters") {
        var id;
        Headquarters headquarters = object as Headquarters;
        if (headquarters.id != null) {
          id = await db.update(tableheadquarters, headquarters.toJson(),
              where: '${HeadquartersFields.id} = ?',
              whereArgs: [headquarters.id]);
        } else {
          id = await db.insert(tableheadquarters, headquarters.toJson());
        }
        return headquarters.copy(id: id);
      } else if (tableName == "pesagem") {
        var id;
        Pesagem pesagem = object as Pesagem;
        if (pesagem.id != null) {
          id = await db.update(tablePesagem, pesagem.toJson(),
              where: '${PesagemFields.id} = ?', whereArgs: [pesagem.id]);
        } else {
          id = await db.insert(tablePesagem, pesagem.toJson());
        }
        return pesagem.copy(id: id);
      } else if (tableName == "historico") {
        var id;
        Historico historico = object as Historico;
        if (historico.id != null) {
          id = await db.update(tablehistorico, historico.toJson(),
              where: '${HistoricoFields.id} = ?', whereArgs: [historico.id]);
        } else {
          id = await db.insert(tablehistorico, historico.toJson());
        }
        return historico.copy(id: id);
      } else if (tableName == "vacina") {
        var id;
        Vacina vacina = object as Vacina;
        if (vacina.id != null) {
          id = await db.update(tablevacina, vacina.toJson(),
              where: '${VacinaFields.id} = ?', whereArgs: [vacina.id]);
        } else {
          id = await db.insert(tablevacina, vacina.toJson());

          Historico historico = Historico(
              idAnimal: object.idAnimal,
              diaOcorrencia: object.dataAplicacao,
              tipo: 2,
              descricao:
                  '--Tipo Vacina--\n\n Nome: ${object.nome}\n\n Data aplicação : ${object.dataAplicacao.toString()} \n\n responsavel: ${object.responsavel}\n\n Local da apicação: ${object.localAplicacao} \n\n Numero do lote: ${object.numeroLote}\n\n Validade: ${object.validade} \n\n Dosagem: ${object.dosagem}ml \n\n Observação: ${object.observacao}');

          await db.insert(tablehistorico, historico.toJson());
        }
        return vacina.copy(id: id);
      } else {
        Note note = object as Note;
        final id = await db.insert(tableGado, note.toJson());
        return note.copy(id: id);
      }
    } catch (e) {
      print(e);
      return Exception("Algo deu errado");
    }
  }

  //FILTRO COM PARTE DA STRING DE BUSCA
  Future<Object> searchDataWithParamiter(String table, String paramsn) async {
    try {
      final db = await instance.database;
      if (table == 'breed') {
        if (paramsn == '') {
          final orderBy = '${BreedFields.name} ASC';

          List<Breed> breeds =
              (await db.rawQuery('SELECT * FROM $tableBreed ORDER BY $orderBy'))
                  .map((row) => Breed.fromJson(row))
                  .toList();

          List<Breed> options = breeds
              .map((breed) => Breed(name: breed.name, id: breed.id))
              .toList();

          return options;
        } else {
          final maps = await db.query(table, where: "${paramsn} LIKE '%?%'");
          return maps;
        }
      } else if (table == 'gado') {
        if (paramsn == '') {
          final orderBy = '${GadoFields.nome} ASC';

          List<Gado> animais =
              (await db.rawQuery('SELECT * FROM $tableGado ORDER BY $orderBy'))
                  .map((row) => Gado.fromJson(row))
                  .toList();

          List<Gado> options = animais
              .map((animal) => Gado(nome: animal.nome, id: animal.id))
              .toList();

          return options;
        } else {
          final maps = await db.query(table, where: "${paramsn} LIKE '%?%' ");
          return maps;
        }
      } else if (table == 'gadoSelecionado') {
        if (paramsn == '') {
          List<Gado> animais = (await db
                  .rawQuery('SELECT * FROM $tableGado WHERE id = $paramsn'))
              .map((row) => Gado.fromJson(row))
              .toList();

          List<Gado> options = animais
              .map((animal) => Gado(nome: animal.nome, id: animal.id))
              .toList();

          return options;
        } else {
          final maps = await db.query(table, where: "${paramsn} LIKE '%?%' ");
          return maps;
        }
      } else {
        return Null;
      }
    } catch (e) {
      print(e);
      return Null;
    }
  }

  Future<Object> searchNameById(int? id) async {
    final db = await instance.database;
    final maps = await db.query(tableBreed,
        columns: BreedFields.values,
        where: '${BreedFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Breed.stringFromJson(maps.first);
    } else {
      return [];
    }
  }

  Future<Object> readNote(String itemString, String argment) async {
    final db = await instance.database;

    if (itemString == "usuario") {
      final searchQuery = '%$argment%';
      final maps = await db.query(
        tableUsuario,
        columns: UsuarioFields.values,
        where: "${UsuarioFields.name} LIKE ?",
        whereArgs: [searchQuery],
      );
      final users = maps.map((userMap) => Usuario.fromJson(userMap)).toList();

      if (maps.isNotEmpty) {
        return users;
      } else {
        return [];
        //throw Exception('ID $itemString not found');
      }
    } else if (itemString == "breed") {
      final searchQuery = '%$argment%';
      final maps = await db.query(
        tableBreed,
        columns: BreedFields.values,
        where: "${BreedFields.name} LIKE ?",
        whereArgs: [searchQuery],
      );
      final breeds = maps.map((breedMap) => Breed.fromJson(breedMap)).toList();
      if (maps.isNotEmpty) {
        return breeds;
      } else {
        return [];
      }
    } else if (itemString == 'gado') {
      final searchQuery = '%$argment%';
      final maps = await db.query(
        tableGado,
        columns: GadoFields.values,
        where: "${GadoFields.nome} LIKE ? OR ${GadoFields.numero} LIKE ?",
        whereArgs: [searchQuery, searchQuery],
      );

      final gados = maps.map((gadoMap) => Gado.fromJson(gadoMap)).toList();
      if (maps.isNotEmpty) {
        return gados;
      } else {
        return [];
      }
    } else if (itemString == "headquarters") {
      final searchQuery = '%$argment%';
      final maps = await db.query(
        tableheadquarters,
        columns: HeadquartersFields.values,
        where: "${HeadquartersFields.name} LIKE ?",
        whereArgs: [searchQuery],
      );

      final headquarters = maps
          .map((headquartersMap) => Headquarters.fromJson(headquartersMap))
          .toList();

      if (maps.isNotEmpty) {
        return headquarters;
      } else {
        return [];
      }
    } else {
      final maps = await db.query(
        tableGado,
        columns: GadoFields.values,
        where: "${GadoFields.nome} LIKE '%?%'",
        whereArgs: ['$itemString'],
      );

      if (maps.isNotEmpty) {
        return Gado.fromJson(maps.first);
      } else {
        //throw Exception('ID $itemString not found');
        return [];
      }
    }
  }

  Future<Object> validadeLogin(
      String itemString, String email, String password) async {
    final db = await instance.database;

    if (itemString == "usuario") {
      var returnRequest;
      final maps = await db.query(
        tableUsuario,
        columns: UsuarioFields.values,
        where: "${UsuarioFields.email} = ? AND ${UsuarioFields.password} = ?",
        whereArgs: [email, password],
      );

      if (maps.isNotEmpty) {
        Usuario user = Usuario.fromJson(maps.first);
        List<Map<String, Object?>> mapsHead = await db.rawQuery('''
          SELECT th.${HeadquartersFields.id} AS h_id, th.${HeadquartersFields.name} AS h_name, th.${HeadquartersFields.number} AS h_number, th.${HeadquartersFields.observacao} AS h_observacao, th.${HeadquartersFields.cpfCnpj} AS h_cpfCnpj
          FROM $tableheadquarters AS th
          INNER JOIN $tableUsuarioHeadquarters AS tuh ON th.${HeadquartersFields.id} = tuh.headquarterId
          INNER JOIN $tableUsuario AS u ON u.${UsuarioFields.id} = tuh.userId
          WHERE u.${UsuarioFields.id} = ?
          ''', [user.id]) as List<Map<String, Object?>>;

        var headquartersList = mapsHead
            .map((objectMap) => HeadQuartersDTO.fromJson(objectMap))
            .toList();

        return LoginResult(user: user, headquartersList: headquartersList);
      } else {
        return [];
      }
    } else {
      final maps = await db.query(
        tableGado,
        columns: GadoFields.values,
        where: "${GadoFields.nome} LIKE '%?%'",
        whereArgs: ['$itemString'],
      );

      if (maps.isNotEmpty) {
        return Gado.fromJson(maps.first);
      } else {
        //throw Exception('ID $itemString not found');
        return Null;
      }
    }
  }

  Future<List<Object>> receveSqlQuery(String sqlValeus) async {
    try {
      final db = await instance.database;

      final result = await db.rawQuery(sqlValeus);
      List<Map<String, dynamic>> resultList = result.toList();

      return resultList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Object>> readAllNotes(String table,
      {int? farmId, int? animalId}) async {
    try {
      final db = await instance.database;

      if (table == "gado") {
        final orderBy = '${GadoFields.nome} ASC';

        final result = await db.rawQuery(
            'SELECT * FROM $tableGado WHERE farmId = $farmId ORDER BY $orderBy');

        return result.map((json) => Gado.fromJson(json)).toList();
      } else if (table == "usuario") {
        final orderBy = '${UsuarioFields.name} ASC';

        final result =
            await db.rawQuery('SELECT * FROM $tableUsuario ORDER BY $orderBy');

        return result.map((json) => Usuario.fromJson(json)).toList();
      } else if (table == "breed") {
        final orderBy = '${BreedFields.name} ASC';

        final result =
            await db.rawQuery('SELECT * FROM $tableBreed ORDER BY $orderBy');

        return result.map((json) => Breed.fromJson(json)).toList();
      } else if (table == "headquarters") {
        final orderBy = '${HeadquartersFields.name} ASC';

        final result = await db
            .rawQuery('SELECT * FROM $tableheadquarters ORDER BY $orderBy');

        return result.map((json) => Headquarters.fromJson(json)).toList();
      } else if (table == "usuarioHeadquarters") {
        final orderBy = '${UsuarioFields.name} ASC';

        final result = await db.rawQuery('''SELECT usuario.*
              FROM $tableUsuario usuario
              INNER JOIN $tableheadquarters headquarters ON usuario.id = headquarters.idUsuario
              WHERE headquarters.id = ?''');

        return result.map((json) => Usuario.fromJson(json)).toList();
      } else if (table == "pesagem") {
        final orderBy = '${PesagemFields.dataPesagem} ASC';
        final result = await db.rawQuery('''
              SELECT * FROM $tablePesagem WHERE gadoId = $animalId ORDER BY $orderBy;
            ''');
        return result.map((json) => Pesagem.fromJson(json)).toList();
      } else if (table == "historico") {
        final orderBy = '${HistoricoFields.diaOcorrencia} ASC';
        final result = await db.rawQuery('''
              SELECT * FROM $tablehistorico WHERE idAnimal = $animalId ORDER BY $orderBy;
            ''');
        return result.map((json) => Historico.fromJson(json)).toList();
      } else if (table == "vacina") {
        final orderBy = '${VacinaFields.dataAplicacao} ASC';
        final result = await db.rawQuery('''
              SELECT * FROM $tablevacina WHERE idAnimal = $animalId ORDER BY $orderBy;
            ''');
        return result.map((json) => Vacina.fromJson(json)).toList();
      } else {
        final orderBy = '${NoteFields.time} ASC';

        final result =
            await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

        return result.map((json) => Note.fromJson(json)).toList();
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id, String tableName) async {
    final db = await instance.database;

    if (tableName == "usuario") {
      return await db.delete(
        tableUsuario,
        where: '${UsuarioFields.id} = ?',
        whereArgs: [id],
      );
    } else if (tableName == 'gado') {
      return await db.delete(
        tableGado,
        where: '${NoteFields.id} = ?',
        whereArgs: [id],
      );
    } else if (tableName == 'breed') {
      return await db.delete(
        tableBreed,
        where: '${BreedFields.id} = ?',
        whereArgs: [id],
      );
    } else if (tableName == 'headquarters') {
      return await db.delete(
        tableheadquarters,
        where: '${HeadquartersFields.id} = ?',
        whereArgs: [id],
      );
    } else if (tableName == 'pesagem') {
      return await db.delete(
        tablePesagem,
        where: '${PesagemFields.id} = ?',
        whereArgs: [id],
      );
    } else if (tableName == 'historico') {
      return await db.delete(
        tablehistorico,
        where: '${HistoricoFields.id} = ?',
        whereArgs: [id],
      );
    } else if (tableName == 'vacina') {
      return await db.delete(
        tablevacina,
        where: '${VacinaFields.id} = ?',
        whereArgs: [id],
      );
    } else {
      return await db.delete(tableNotes);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
