// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Detail_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorDetaildatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DetaildatabaseBuilder databaseBuilder(String name) =>
      _$DetaildatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DetaildatabaseBuilder inMemoryDatabaseBuilder() =>
      _$DetaildatabaseBuilder(null);
}

class _$DetaildatabaseBuilder {
  _$DetaildatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$DetaildatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DetaildatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<Detaildatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$Detaildatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$Detaildatabase extends Detaildatabase {
  _$Detaildatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  Detaildao? _detaildaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `detail` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `ordertype` TEXT NOT NULL, `addresstype` TEXT NOT NULL, `flat` TEXT NOT NULL, `area` TEXT NOT NULL, `near` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  Detaildao get detaildao {
    return _detaildaoInstance ??= _$Detaildao(database, changeListener);
  }
}

class _$Detaildao extends Detaildao {
  _$Detaildao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _detail_tableInsertionAdapter = InsertionAdapter(
            database,
            'detail',
            (Detail_table item) => <String, Object?>{
                  'id': item.id,
                  'ordertype': item.ordertype,
                  'addresstype': item.addresstype,
                  'flat': item.flat,
                  'area': item.area,
                  'near': item.near
                },
            changeListener),
        _detail_tableDeletionAdapter = DeletionAdapter(
            database,
            'detail',
            ['id'],
            (Detail_table item) => <String, Object?>{
                  'id': item.id,
                  'ordertype': item.ordertype,
                  'addresstype': item.addresstype,
                  'flat': item.flat,
                  'area': item.area,
                  'near': item.near
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Detail_table> _detail_tableInsertionAdapter;

  final DeletionAdapter<Detail_table> _detail_tableDeletionAdapter;


  @override
  Stream<List<Detail_table>> getalldetail() {
    return _queryAdapter.queryListStream('select * from detail',
        mapper: (Map<String, Object?> row) => Detail_table(
            row['ordertype'] as String,
            row['addresstype'] as String,
            row['flat'] as String,
            row['area'] as String,
            row['near'] as String,
            id: row['id'] as int?),
        queryableName: 'detail',
        isView: false);
  }

  @override
  Future<void> updatedetail(
    String id,
    String ordertype,
    String addresstype,
    String area,
    String flat,
    String near,
  ) async {
    await _queryAdapter.queryNoReturn(
        'update detail set addresstype =?3,ordertype =?2,area =?4,flat =?5,near =?6 where id=?1',
        arguments: [id, ordertype, addresstype, area, flat, near]);
  }

  @override
  Future<void> adddetail(Detail_table detailtable) async {
    await _detail_tableInsertionAdapter.insert(
        detailtable, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletedetail(Detail_table detailtable) async {
    await _detail_tableDeletionAdapter.delete(detailtable);
  }
}
