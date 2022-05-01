import 'package:ebrana_schody/db/achievement.dart';
import 'package:ebrana_schody/db/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FloorsDatabase{
  static final FloorsDatabase instance = FloorsDatabase._init();
  static Database? _database;

  FloorsDatabase._init();

  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDB('floors-edited.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 8, onCreate: _createDB, onUpgrade: _onUpgrade);
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
    await db.execute('''
    CREATE TABLE $tableAchievement (
      ${AchievementFields.id} $idType,
      ${AchievementFields.user_id} $textType,
      ${AchievementFields.datestamp} $textType,
      ${AchievementFields.achievementlvl} $intType
    )
    ''');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async{
    oldVersion = 7;
    newVersion = 8;

    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final intType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableAchievement (
      ${AchievementFields.id} $idType,
      ${AchievementFields.user_id} $textType,
      ${AchievementFields.datestamp} $textType,
      ${AchievementFields.achievementlvl} $intType
    )
    ''');
  }

  Future<User> create(User user) async{
    final db = await instance.database;

    final id = await db.insert(tableUser, user.toJson());
    return user.copy(id:id);
  }

  Future<User> readUser(String login) async{
    final db = await instance.database;

    final maps = await db.query(
      tableUser,
      columns: UserFields.values,
      where: '${UserFields.login} = ?',
      whereArgs: [login],
    );

    if(maps.isNotEmpty){
      return User.fromJson(maps.first);
    }else{
      throw Exception('ID $login not found');
    }
  }

  Future<List<User>> readAllUsers() async{
    final db = await instance.database;

    final result = await db.query(tableUser);
    
    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<List<User>> readAllUsersForStats() async{
    final db = await instance.database;

    final orderBy = '${UserFields.floors} DESC';
    final prom = 0;
    final where = '${UserFields.floors} >$prom';
    final result = await db.query(tableUser,where: where,orderBy: orderBy);

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

  Future<Achievement> createAchievement(Achievement achievement) async{
    final db = await instance.database;
    int achilvl= achievement.achievementlvl;
    String UID = achievement.user_id;
    DateTime Date = achievement.datestamp;

    //final id = await db.insert(tableAchievement, achievement.toJson());

    final id = await db.rawInsert('''
    INSERT INTO $tableAchievement (${AchievementFields.user_id}, ${AchievementFields.datestamp},${AchievementFields.achievementlvl})
      SELECT * FROM (SELECT '$UID', '$Date', '$achilvl') AS tmp
      WHERE NOT EXISTS (
      SELECT ${AchievementFields.user_id},${AchievementFields.achievementlvl} FROM $tableAchievement 
      WHERE ${AchievementFields.user_id} = '$UID' AND ${AchievementFields.achievementlvl} = '$achilvl'
    ) LIMIT 1;
    )
    ''');

    return achievement.copy(id:id);
  }

  Future<List<Achievement>> readAllAchievements() async{
    final db = await instance.database;
    final orderBy = '${AchievementFields.datestamp} DESC';
    final result = await db.query(tableAchievement, orderBy: orderBy);

    return result.map((json) => Achievement.fromJson(json)).toList();
  }

  Future<int> updateAchievement(Achievement achievement) async{
    final db = await instance.database;

    return db.update(
      tableAchievement,
      achievement.toJson(),
      where: '${AchievementFields.id} = ?',
      whereArgs: [achievement.id],
    );
  }


  Future close() async{
    final db = await instance.database;
    db.close();
  }

  Future<int> deleteAchi() async{
    final db = await instance.database;

    return await db.rawDelete('DELETE FROM $tableAchievement');
  }
}