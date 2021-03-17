import 'package:app1/src/models/itemcompra_model.dart';
import 'package:app1/src/models/listacompra_model.dart';
import 'package:app1/src/repo/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  static const String TABELA_LISTA = DBProvider.T_LISTA_COMPRA;
  static const String TABELA_ITEM = DBProvider.T_ITEM_COMPRA;

  Future<List<ListaCompraModel>> getListas() async {
    var dbClient = await DBProvider.instance.db;
    List<Map> maps = await dbClient.rawQuery("""
      SELECT li.*,
      ( SELECT COUNT(*) AS qtditens FROM $TABELA_ITEM it WHERE it.listacompra_id = li.id ) 
      FROM $TABELA_LISTA li WHERE li.deletado == 0
      ORDER BY ID DESC
    """);
    //
    List<ListaCompraModel> listas = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        listas.add(ListaCompraModel.fromMap(maps[i]));
      }
    }
    return listas;
  }

  Future<ListaCompraModel> salvarLista(ListaCompraModel lista) async {
    var db = await DBProvider.instance.db;
    lista.id = await db.insert(
      TABELA_LISTA,
      lista.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return lista;
  }

  Future<int> atualizarLista(ListaCompraModel lista) async {
    var dbClient = await DBProvider.instance.db;
    return await dbClient.update(DBProvider.T_LISTA_COMPRA, lista.toMap(),
        where: 'id = ?', whereArgs: [lista.id]);
  }

  Future<List<ItemCompraModel>> getItens(int listaId) async {
    var dbClient = await DBProvider.instance.db;
    List<Map> maps = await dbClient.rawQuery("""
      SELECT * FROM $TABELA_ITEM 
      WHERE deletado != 0 AND id = $listaId
      ORDER BY ID DESC
    """);
    //
    List<ItemCompraModel> itens = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        itens.add(ItemCompraModel.fromMap(maps[i]));
      }
    }
    return itens;
  }

  Future<ItemCompraModel> salvarItem(ItemCompraModel item) async {
    var db = await DBProvider.instance.db;
    item.id = await db.insert(
      TABELA_ITEM,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return item;
  }

  Future<int> atualizarItem(ItemCompraModel item) async {
    var dbClient = await DBProvider.instance.db;
    return await dbClient.update(TABELA_ITEM, item.toMap(),
        where: 'id = ?', whereArgs: [item.id]);
  }
}
