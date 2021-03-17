import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static const String T_LISTA_COMPRA = "lista_compra";
  static const String T_ITEM_COMPRA = "item_compra";

  DBProvider._();
  static final DBProvider instance = DBProvider._();
  Database _database;

  Future<Database> get db async {
    if (_database != null) return _database;

    _database = await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "checklist_compras.db");
    return await openDatabase(path, version: 1, onCreate: _oncreate);
  }

  void _oncreate(Database db, int version) async {
    /**/
    await db.execute("""
          CREATE TABLE $T_LISTA_COMPRA(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          deletado BOOLEAN,
          datacriacao TEXT
          )
      """);
    /**/
    await db.execute("""
          CREATE TABLE $T_ITEM_COMPRA(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          qtd INTEGER,
          deletado BOOLEAN,
          valor DOUBLE,
          ordem INTEGER,
          nocarrinho BOOLEAN,
          listacompra_id INTEGER 
          )
      """);
  }
}
