import 'package:floor/floor.dart';

@Entity(tableName: "detail")

class Detail_table{
  @PrimaryKey(autoGenerate: true)
  int? id;
  String ordertype;
  String addresstype;
  String flat;
  String area;
  String near;
  double latitude;
  double longitude;

  Detail_table(this.ordertype, this.addresstype, this.flat, this.area, this.near,this.latitude,this.longitude,{ this.id});
}