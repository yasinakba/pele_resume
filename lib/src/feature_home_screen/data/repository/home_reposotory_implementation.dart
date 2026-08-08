import 'package:pele_resume/src/feature_home_screen/data/data_source/local/local_service.dart';
import 'package:pele_resume/src/feature_home_screen/data/model/todo_model.dart';
import 'package:pele_resume/src/feature_home_screen/domain/entity/todo_entity.dart';
import 'package:pele_resume/src/feature_home_screen/domain/repository/home_repository.dart';

class HomeRepositoryImplementation implements HomeRepository{
  final LocalServices localServices;
  HomeRepositoryImplementation({required this.localServices});
  @override
  Future<void> addTODO({required ToDoModel todoEntity}) async{
   await localServices.addToDo(todo: todoEntity);
  }
  
}