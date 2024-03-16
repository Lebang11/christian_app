import 'package:isar/isar.dart';

part 'diary.g.dart';

@collection
class diary {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  late String title;
  late String text;
  late String date;
}
