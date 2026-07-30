import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pele_resume/src/feature_home_screen/domain/repository/home_repository.dart';
import 'package:pele_resume/src/feature_home_screen/domain/usecase/add_todo_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      if(event is AddToDoEvent){
        AddToDoUseCase(homeRepository: HomeRepository());
      }
    });
  }
}
