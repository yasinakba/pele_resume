import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/bloc/home_bloc.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/pages/add_screen.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../widget/text_feild_widget.dart'; // پکیج تاریخ شمسی

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool add = false;
  TextEditingController addController = TextEditingController();
  // تولید لیستی از روزهای شمسی (مثلاً ۳۰ روز قبل تا ۳۰ روز بعد از امروز)
  final List<Jalali> _days = List.generate(61, (index) {
    return Jalali.now().addDays(index - 30);
  });

  late PageController _pageController;
  int _selectedIndex = 30;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
    });
    _pageController =
        PageController(initialPage: _selectedIndex, viewportFraction: 1.0);
  }

  // متد برای گرفتن نام روز هفته به فارسی
  String _getWeekDayName(Jalali date) {
    // شماره روزهای هفته در شمسی از 1 (شنبه) تا 7 (جمعه) است
    final Map<int, String> persianWeekDays = {
      1: 'شـنبه',
      2: 'یکـشنبه',
      3: 'دوشنبه',
      4: 'سه‌شـنبه',
      5: 'چهارشـنبه',
      6: 'پنج‌شـنبه',
      7: 'جمـعه',
    };

    // استفاده از date.weekDay که یک عدد بین 1 تا 7 است
    return persianWeekDays[date.weekDay] ?? '';
  }

  void _scrollToSelected() {
    const itemWidth = 78.0;

    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    final offset =
        (_selectedIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

    scrollController.animateTo(
      offset.clamp(
        0.0,
        scrollController.position.maxScrollExtent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("تقویم شمسی")),
      body: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: 90,
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch
                }),
                child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _days.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                          _pageController.jumpToPage(index);
                        });
                      },
                      child: Container(
                        width: 70,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.withOpacity(0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_getWeekDayName(_days[index]),
                                style: TextStyle(fontSize: 12)),
                            Text("${_days[index].day}", style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) =>
                    setState(() => _selectedIndex = index),
                itemCount: _days.length,
                itemBuilder: (context, index) {
                  // تاریخ به فرمت کامل برای استفاده در کوئری دیتابیس
                  final date = _days[index];
                  return Center(
                      child: Text(
                          "تاریخ انتخاب شده: ${date.year}/${date.month}/${date
                              .day}")
                  );
                },
              ),
            ),
          ),
          Visibility(child: TextFieldWidget(controller:addController, type: TextInputType.text,
            hint: 'در مورد تسک توصیح دهید...',
            icon: Icons.send,
            tooltip: 'توضیحات تسک',
            onTap: () {
              BlocProvider.of<HomeBloc>(context).add(AddToDoEvent());
            },
          )),
        ],
      ),
      floatingActionButton: Visibility(
        visible: !add,
        child: FloatingActionButton(onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddScreen(),));
        }, child: Icon(Icons.add),),
      ),
    );
  }
}