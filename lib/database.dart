// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// user in database
// todo: implement a more complex user modelling + ML
class User {
  String name;
  String email;
  DateTime birthDate;
  String password;

  User(
      {required this.name,
      required this.email,
      required this.birthDate,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'password': password,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      birthDate: DateTime.parse(map['birthDate']),
      password: map['password'],
    );
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }
    _database = await initializeDB();
    return _database!;
  }

  String usersTable = 'users';
  String colName = 'name';
  String colEmail = 'email';
  String colBirthDate = 'birthDate';
  String colPassword = 'password';

  Future<Database> initializeDB() async {
    String dbpath = await getDatabasesPath();

    return openDatabase(
      join(dbpath, 'database.db'),
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE $usersTable(
            $colName TEXT,
            $colEmail TEXT,
            $colBirthDate TEXT,
            $colPassword TEXT
          );
          ''');
      },
      version: 1,
    );
  }

  // insert user
  Future<int> insertUser(User user) async {
    final db = await this.db;
    return await db.insert(usersTable, user.toMap());
  }

  //authenticate user
  Future<User?> getUserByEmailAndPassword(String email, String password) async {
    final db = await this.db;
    final maps = await db.query(usersTable,
        where: '$colEmail = ? AND $colPassword = ?',
        whereArgs: [email, password]);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
