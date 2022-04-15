import 'package:hive/hive.dart';
part 'escaperoom.g.dart';

@HiveType(typeId: 0)
class EscapeRoom extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String nombre;
  @HiveField(2)
  String ciudad;
  @HiveField(3)
  double precio;
  @HiveField(4)
  int dificultad;
  @HiveField(5)
  String tiempo;
  @HiveField(6)
  String tematica;
  @HiveField(7)
  String empresa;
  @HiveField(8)
  String descripcion;
}
