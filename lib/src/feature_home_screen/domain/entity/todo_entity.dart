import 'package:equatable/equatable.dart';

class ToDoEntity extends Equatable {
  final String name, priority;
  final int createdAt;

  ToDoEntity({
    required this.name,
    required  this.priority,
    required this.createdAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name,createdAt];
}
