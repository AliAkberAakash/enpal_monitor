import 'package:enpal_monitor/features/usage_monitor/data/local/dao/usage_monitor_data_local.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UsageMonitorDataLocalDao {
  static const String _tableName = 'usage_monitor_data';
  static const _databaseName = "usage_monitor_database.db";

  /// Singleton pattern for database instance
  static final UsageMonitorDataLocalDao instance =
      UsageMonitorDataLocalDao._init();
  static Database? _database;

  UsageMonitorDataLocalDao._init();

  /// Initialize database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(_databaseName);
    return _database!;
  }

  /// Create database and table
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  /// Create table
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        timestamp INTEGER NOT NULL,
        value INTEGER NOT NULL,
        commonId TEXT NOT NULL
      )
    ''');

    /// Create an index on commonId for faster queries
    await db.execute('''
      CREATE INDEX idx_common_id ON $_tableName (commonId)
    ''');
  }

  /// Batch insert method for multiple objects
  Future<void> insertBatch(List<UsageMonitorDataLocal> dataList) async {
    final db = await database;

    /// Use transaction for bulk insert
    await db.transaction((txn) async {
      final batch = txn.batch();

      for (final data in dataList) {
        batch.insert(
          _tableName,
          data.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      await batch.commit(noResult: true);
    });
  }

  /// Method to delete all records
  Future<void> deleteAll() async {
    final db = await database;
    await db.delete(_tableName);
  }

  /// Method to delete all data for a specific commonId
  Future<void> deleteByCommonId(String commonId) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'commonId = ?',
      whereArgs: [commonId],
    );
  }

  Future<List<UsageMonitorDataLocal>> getAllData() async {
    final db = await database;
    final maps = await db.query(_tableName);
    return maps.map((map) => UsageMonitorDataLocal.fromMap(map)).toList();
  }

  /// Query by commonId
  Future<List<UsageMonitorDataLocal>> getDataByCommonId(String commonId) async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      where: 'commonId = ?',
      whereArgs: [commonId],
    );
    return maps.map((map) => UsageMonitorDataLocal.fromMap(map)).toList();
  }

  /// Close the database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
