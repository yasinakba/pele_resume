import 'dart:ui';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/bloc/home_bloc.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/pages/category_widget.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/pages/daily_widget.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/pages/monthly.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../widget/text_feild_widget.dart'; // پکیج تاریخ شمسی

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final _tabController ;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _tabController = TabController(length: 3, vsync: this,);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: TabBar(
        unselectedLabelColor: Colors.black,
        indicatorColor: Colors.black,
          tabAlignment: TabAlignment.center,
          controller: _tabController,
          tabs: [
        Tab(text: 'روزانه',icon: Icon(Icons.calendar_view_day),),
        Tab(text: 'ماهانه',icon: Icon(Icons.calendar_month),),
        Tab(text: 'دسته بندی ها',icon: Icon(Icons.category),)
      ]),),
      body: TabBarView(
        controller: _tabController,
        children: [
          DailyWidget(),
          MonthlyWidget(),
          CategoryWidget(),
        ],
      ),

    );
  }
}

