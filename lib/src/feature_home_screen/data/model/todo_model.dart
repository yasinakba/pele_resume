import 'package:hive/hive.dart';
import 'package:pele_resume/src/feature_home_screen/domain/entity/todo_entity.dart';

part 'todo_model.g.dart';
@HiveType(typeId: 0)
class ToDoModel extends ToDoEntity {
  @HiveField(0)
  String name;
  @HiveField(1)   
  String  priority;
  @HiveField(2)
  int id;
  @HiveField(3)
 int createdAt;

  ToDoModel({
    required this.name,
    required this.priority,
    required this.id,
    required this.createdAt,
  }) : super(createdAt: createdAt, name: name, id: id, priority: priority);

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
    name: json['name'],
    priority: json['priority'],
    id: json['id'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson()=> {
    'name':name,
    'priority':priority,
    'id':id,
    'createdAt':createdAt
  };
}
