import 'package:pele_resume/src/feature_home_screen/data/model/todo_model.dart';

abstract class HomeRepository {
  Future<void> addTODO({required ToDoModel todoEntity});
}