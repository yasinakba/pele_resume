import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pele_resume/core/constatnt/constant.dart';
import 'package:pele_resume/src/feature_home_screen/domain/entity/todo_entity.dart';
import 'package:pele_resume/src/feature_nav_screen/bottom_navigation_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: BottomNavigationBarWidget(),
      ),
    );
  }
}


