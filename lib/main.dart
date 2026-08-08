import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pele_resume/core/constatnt/constant.dart';
import 'package:pele_resume/src/feature_home_screen/data/model/todo_model.dart';
import 'package:pele_resume/src/feature_home_screen/domain/entity/todo_entity.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/bloc/home_bloc.dart';
import 'package:pele_resume/src/feature_nav_screen/bottom_navigation_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Hive.registerAdapter(ToDoModelAdapter());
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox<ToDoEntity>(todoBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(width, height),
      child: BlocProvider(
        create: (context) => HomeBloc(),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: BottomNavigationBarWidget(),
        ),
      ),
    );
  }
}


