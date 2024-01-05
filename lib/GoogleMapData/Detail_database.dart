import 'package:Pizza/GoogleMapData/DetailDao.dart';
import 'package:Pizza/GoogleMapData/Detail_table.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'Detail_database.g.dart';

@Database(version: 1, entities: [Detail_table])
abstract class Detaildatabase extends FloorDatabase {
  Detaildao get detaildao;
}
