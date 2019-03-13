import 'dart:async';
import 'dart:io';

import 'package:forecanvass/model/PersonModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  // Checks if database exists.
  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  // Creates database if one isn't on the device already. Will not create a new database
  // if one exists already.
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Person ("
          "personId INTEGER PRIMARY KEY AUTOINCREMENT,"
          "firstName TEXT NOT NULL,"
          "lastName TEXT NOT NULL,"
          "temporaryCode INTEGER NOT NULL,"
          "country TEXT NOT NULL,"
          "province TEXT NOT NULL,"
          "city TEXT NOT NULL,"
          "streetName TEXT NOT NULL,"
          "streetNumber INTEGER NOT NULL,"
          "unitNumber INTEGER,"
          "postalCode TEXT NOT NULL,"
          "mark TEXT,"
          "sign BIT DEFAULT 0,"
          "volunteer BIT DEFAULT 0,"
          "donate BIT DEFAULT 0,"
          "phoneNumber INTEGER,"
          "email TEXT,"
          "notes TEXT"
          ")");
      await db.insert(
          "Person",
          Person(
            firstName: "Jon",
            lastName: "Snow",
            temporaryCode: 123456,
            country: "Canada",
            province: "Ontario",
            city: "Ottawa",
            streetName: "Woodroffe Avenue",
            streetNumber: 1385,
            postalCode: "K2G1V8",
            phoneNumber: 6137274723,
            sign: 0,
            donate: 0,
            volunteer: 0,
          ).toMap());
      await db.insert(
          "Person",
          Person(
            firstName: "Daenerys",
            lastName: "Targaryen",
            temporaryCode: 123456,
            country: "Canada",
            province: "Ontario",
            city: "Ottawa",
            streetName: "Woodroffe Avenue",
            streetNumber: 1385,
            postalCode: "K2G1V8",
            sign: 0,
            donate: 0,
            volunteer: 0,
          ).toMap());
      await db.insert(
          "Person",
          Person(
            firstName: "Arya",
            lastName: "Stark",
            temporaryCode: 123456,
            country: "Canada",
            province: "Ontario",
            city: "Ottawa",
            streetName: "Woodroffe Avenue",
            streetNumber: 1380,
            postalCode: "K2G1V8",
            sign: 0,
            donate: 0,
            volunteer: 0,
          ).toMap());
      await db.insert(
          "Person",
          Person(
            firstName: "Tyrion",
            lastName: "Lannister",
            temporaryCode: 123456,
            country: "Canada",
            province: "Ontario",
            city: "Ottawa",
            streetName: "Parkglen Dr",
            streetNumber: 50,
            postalCode: "K2G3G8",
            sign: 0,
            donate: 0,
            volunteer: 0,
          ).toMap());
      await db.insert(
          "Person",
          Person(
            firstName: "Bill",
            lastName: "Jones",
            temporaryCode: 111222,
            country: "Canada",
            province: "Ontario",
            city: "Ottawa",
            streetName: "Parkglen Dr",
            streetNumber: 50,
            postalCode: "K2G3G8",
            sign: 0,
            donate: 0,
            volunteer: 0,
          ).toMap());
    });
  }

  // Method to help translate bits in SQLite to boolean.
  bool intToBool(int sqlBit) {
    if (sqlBit == 0) return false;

    if (sqlBit == 1) return true;

    return null;
  }

  // Method to help translate boolean in Dart to bits for SQLite.
  int boolToInt(bool sqlBit) {
    if (sqlBit == false) return 0;

    if (sqlBit == true) return 1;

    return -1;
  }

  // Method to get a list of people with the same temporary code.
  Future<List<Person>> getPeopleList(int temporaryCode) async {
    final db = await database;
    var res = await db.query("Person",
        where: "temporaryCode = ?", whereArgs: [temporaryCode]);
    List<Person> list =
        res.isNotEmpty ? res.map((c) => Person.fromMap(c)).toList() : [];
    return list;
  }

  // Update single person's info in database
  updatePerson(Person person) async {
    final db = await database;
    var res = await db.update("Person", person.toMap(),
        where: "personId = ?", whereArgs: [person.personId]);
    return res;
  }

  // Add new person entirely
  newPerson(Person newPerson) async {
    final db = await database;
    var res = await db.insert("Person", newPerson.toMap());
    return res;
  }
}
