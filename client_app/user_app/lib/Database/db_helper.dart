import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:user_app/models/cart_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDatabase();
  }

  initDatabase() async {
    //creating path inside mobile to create database
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();

    //getting path
    String path = join(documentDirectory.path, 'cart.db');

    //setting path
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE cart (itemId TEXT PRIMARY KEY, productId TEXT UNIQUE,productQuantity INTEGER, productName TEXT,initialPrice INTEGER, productPrice INTEGER, productImage TEXT)',
    );
  }

  Future<Cart> insert(Cart cart) async {
    var dbClient = await db;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }

  Future<int> delete(int itemId) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'cart',
      where: 'itemId = ?',
      whereArgs: [itemId],
    );
  }

  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await db;
    return await dbClient!.update(
      'cart',
      cart.toMap(),
      where: 'itemId = ?',
      whereArgs: [cart.itemId],
    );
  }
}
