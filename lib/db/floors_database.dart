import 'package:ebrana_schody/db/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FloorsDatabase{
  static final FloorsDatabase instance = FloorsDatabase._init();
  static Database? _database;

  FloorsDatabase._init();

  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDB('floors.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableUser (
      ${UserFields.id} $idType,
      ${UserFields.email} $textType,
      ${UserFields.login} $textType,
      ${UserFields.password} $textType,
      ${UserFields.floors} $intType
    )
    ''');
  }

  Future<User> create(User user) async{
    final db = await instance.database;

    final id = await db.insert(tableUser, user.toJson());
    return user.copy(id:id);
  }

  Future<User> readUser(int id) async{
    final db = await instance.database;

    final maps = await db.query(
      tableUser,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return User.fromJson(maps.first);
    }else{
      throw Exception('ID $id not found');
    }
  }

  Future<List<User>> readAllUsers() async{
    final db = await instance.database;

    final result = await db.query(tableUser);
    
    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> update(User user) async{
    final db = await instance.database;

    return db.update(
      tableUser,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableUser,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
}