import 'package:pele_resume/core/usecase/usecase.dart';
import 'package:pele_resume/src/feature_home_screen/data/model/todo_model.dart';
import 'package:pele_resume/src/feature_home_screen/domain/repository/home_repository.dart';

class AddToDoUseCase implements UseCase<void,ToDoModel>{
  final HomeRepository homeRepository;
  AddToDoUseCase({required this.homeRepository});

  @override
  Future<void> call({required ToDoModel params}) {
   return homeRepository.addTODO(todoEntity: params);

  }


}