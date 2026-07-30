import 'package:equatable/equatable.dart';

class ToDoEntity extends Equatable {
  final String name, priority;
  final int id, createdAt;

  ToDoEntity({
    required this.name,
    required  this.priority,
    required  this.id,
    required this.createdAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name,id,createdAt];
}
