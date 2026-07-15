import 'package:flutter_signin/models/item_Model/item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton Pattern
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'kera.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        images TEXT,
        status TEXT,
        available INTEGER,
        location TEXT,
        priceAssurance REAL,
        deliveryMethod TEXT,
        pricePerHour REAL,
        pricePerDay REAL,
        quantity INTEGER,
        minRentalDuration INTEGER,
        maxRentalDuration INTEGER,
        availabilityHours INTEGER,
        userId INTEGER,
        categoryId INTEGER
      )
    ''');
  }

  Future<int> insertItem(Item item) async {
    try {
      final db = await database;
      return await db.insert('items', item.toMap());
    } catch (e) {
      print('Error inserting item: $e');
      return -1; // رمز خطأ
    }
  }

  Future<List<Item>> getItems() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('items');

      return List.generate(maps.length, (i) {
        return Item.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error retrieving items: $e');
      return [];
    }
  }

  Future<int> updateItem(Item item) async {
    try {
      final db = await database;
      return await db.update(
        'items',
        item.toMap(),
        where: 'id = ?',
        whereArgs: [item.id],
      );
    } catch (e) {
      print('Error updating item: $e');
      return -1; // رمز خطأ
    }
  }

  Future<int> deleteItem(int id) async {
    try {
      final db = await database;
      return await db.delete(
        'items',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting item: $e');
      return -1; // رمز خطأ
    }
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}