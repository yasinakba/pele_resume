import 'package:pele_resume/core/usecase/usecase.dart';
import 'package:pele_resume/src/feature_home_screen/domain/entity/todo_entity.dart';
import 'package:pele_resume/src/feature_home_screen/domain/repository/home_repository.dart';

class AddToDoUseCase implements UseCase<void,ToDoEntity>{
  final HomeRepository homeRepository;
  AddToDoUseCase({required this.homeRepository});

  @override
  Future<void> call({required ToDoEntity params}) {
   return homeRepository.addTODO(todoEntity: params);

  }


}