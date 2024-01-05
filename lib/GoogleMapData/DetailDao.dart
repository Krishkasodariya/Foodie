import 'package:Pizza/GoogleMapData/Detail_table.dart';
import 'package:floor/floor.dart';

@dao
abstract class Detaildao {
  @Query("select * from detail")
  Stream<List<Detail_table>> getalldetail();

  @insert
  Future<void> adddetail(Detail_table detailtable);

  @delete
  Future<void> deletedetail(Detail_table detailtable);

  @Query(
      "update detail set addresstype =:addresstype,ordertype =:ordertype,area =:area,flat =:flat,near =:near where id=:id")
  Future<void> updatedetail(String id, String ordertype, String addresstype,
      String area, String flat, String near);
}
