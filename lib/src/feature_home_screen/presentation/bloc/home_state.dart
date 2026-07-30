part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class AddToDoLoading extends HomeState {}
class AddToDoError extends HomeState {
  final Exception error;
  AddToDoError({required this.error});
}
class AddToDoSuccess extends HomeState{}

