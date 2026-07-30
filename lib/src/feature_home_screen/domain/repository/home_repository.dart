import 'package:pele_resume/src/feature_home_screen/domain/entity/todo_entity.dart';

abstract class HomeRepository {
  Future<void> addTODO({required ToDoEntity todoEntity});
}