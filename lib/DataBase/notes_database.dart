import 'package:app_veterinaria/Model/breed.dart';
import 'package:app_veterinaria/Model/gado.dart';
import 'package:app_veterinaria/Model/headquarters.dart';
import 'package:app_veterinaria/Model/note.dart';
import 'package:app_veterinaria/Model/usuario.dart';
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

    //await deleteDatabase(path);

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
  ${GadoFields.dataNascimento} $textType,
  ${GadoFields.dataBaixa} $nulldateType,
  ${GadoFields.motivoBaixa} $textType,
  ${GadoFields.partosNaoLancados} $nulltextType,
  ${GadoFields.partosTotais} $nulltextType,
  ${GadoFields.lote} $nulltextType,
  ${GadoFields.nomeMae} $nulltextType,
  ${GadoFields.nomePai} $nulltextType,
  ${GadoFields.numeroMae} $nulltextType,
  ${GadoFields.numeroPai} $nulltextType,
  ${GadoFields.breedId} $nullIntType
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
INSERT INTO $tableUsuario (name, email, password) VALUES ('ADMIN', 'admin@gmail.com', 'admin123')
''');
  }

  Future<Object> create(Object object, String tableName) async {
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
    } else {
      Note note = object as Note;
      final id = await db.insert(tableGado, note.toJson());
      return note.copy(id: id);
    }
    // final json = note.toJson();

    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';

    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';

    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');
  }

  //FILTRO COM PARTE DA STRING DE BUSCA
  Future<Object> searchDataWithParamiter(String table, String paramsn) async {
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
      } else
        final maps = await db.query(table, where: "${paramsn} LIKE '%?%'");
      return Null;
    } else {
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
        returnRequest = (await db.query(tableheadquarters,
            columns: HeadquartersFields.values,
            where: "${HeadquartersFields.idUsuario} = ?",
            whereArgs: [user.id]));

        returnRequest = returnRequest
            .map((objectMap) => Headquarters.fromJson(objectMap))
            .toList();

        return returnRequest;
      } else {
        return false;
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

  Future<List<Object>> readAllNotes(String table) async {
    final db = await instance.database;

    if (table == "gado") {
      final orderBy = '${GadoFields.nome} ASC';

      final result =
          await db.rawQuery('SELECT * FROM $tableGado ORDER BY $orderBy');

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
    } else {
      final orderBy = '${NoteFields.time} ASC';

      final result =
          await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

      return result.map((json) => Note.fromJson(json)).toList();
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
    } else {
      return await db.delete(tableNotes);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
