import 'package:pele_resume/core/constatnt/constant.dart';
import 'package:pele_resume/src/feature_home_screen/data/model/todo_model.dart';
import 'package:pele_resume/src/feature_home_screen/domain/entity/todo_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalServices{
  final box = Hive.box<ToDoModel>(todoBox);

  Future<void> addToDo({required ToDoModel todo})async{
    int result = await box.add(ToDoModel(name: todo.name, priority: todo.priority, createdAt: todo.createdAt));
    print(result);
  }
}