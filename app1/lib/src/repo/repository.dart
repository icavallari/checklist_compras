import 'package:app1/src/models/item.dart';
import 'package:app1/src/models/lista.dart';
import 'package:app1/src/repo/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  static const String TABELA_LISTA = DBProvider.T_LISTA_COMPRA;
  static const String TABELA_ITEM = DBProvider.T_ITEM_COMPRA;

  Future<Lista> getLista(int id) async {
    var dbClient = await DBProvider.instance.db;
    List<Map> maps = await dbClient.rawQuery("""
      SELECT * FROM $TABELA_LISTA WHERE id = ?
    """, [id]);
    //
    return Lista.fromMap(maps[0]);
  }

  Future<List<Lista>> getListas() async {
    var dbClient = await DBProvider.instance.db;
    List<Map> maps = await dbClient.rawQuery("""
      SELECT li.*,
      ( SELECT COUNT(*) AS qtditens FROM $TABELA_ITEM it WHERE it.listacompra_id = li.id ) 
      FROM $TABELA_LISTA li WHERE li.deletado == 0
      ORDER BY ID DESC
    """);
    //
    List<Lista> listas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        listas.add(Lista.fromMap(maps[i]));
      }
    }
    return listas;
  }

  Future<Lista> salvarLista(Lista lista) async {
    var db = await DBProvider.instance.db;
    lista.id = await db.insert(
      TABELA_LISTA,
      lista.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return lista;
  }

  Future<int> atualizarLista(Lista lista) async {
    var dbClient = await DBProvider.instance.db;
    return await dbClient.update(DBProvider.T_LISTA_COMPRA, lista.toMap(),
        where: 'id = ?', whereArgs: [lista.id]);
  }

  Future<List<Item>> getItens(int listaId) async {
    var dbClient = await DBProvider.instance.db;
    List<Map> maps = await dbClient.rawQuery("""
      SELECT * FROM $TABELA_ITEM 
      WHERE deletado == 0 AND listacompra_id = ?
      ORDER BY ID DESC
    """, [listaId]);
    //
    List<Item> itens = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        itens.add(Item.fromMap(maps[i]));
      }
    }
    return itens;
  }

  Future<Item> salvarItem(Item item) async {
    var db = await DBProvider.instance.db;
    item.id = await db.insert(
      TABELA_ITEM,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return item;
  }

  Future<int> atualizarItem(Item item) async {
    var dbClient = await DBProvider.instance.db;
    return await dbClient.update(TABELA_ITEM, item.toMap(),
        where: 'id = ?', whereArgs: [item.id]);
  }
}
