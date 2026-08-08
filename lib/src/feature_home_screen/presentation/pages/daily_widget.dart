import 'dart:ui';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jalali_flutter_datepicker/jalali_flutter_datepicker.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/widget/text_feild_widget.dart';

import '../bloc/home_bloc.dart';

class DailyWidget extends StatefulWidget {
  const DailyWidget({super.key});
  static String priority = '';
  static  bool showPriority = false;
  @override
  State<DailyWidget> createState() => _DailyWidgetState();
}

class _DailyWidgetState extends State<DailyWidget> with SingleTickerProviderStateMixin {
  TextEditingController addController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool showEmoji = false;

  // تولید لیستی از روزهای شمسی (مثلاً ۳۰ روز قبل تا ۳۰ روز بعد از امروز)
  final List<Jalali> _days = List.generate(61, (index) {
    return Jalali.now().addDays(index - 30);
  });

  late PageController _pageController;
  int _selectedIndex = 30;
  ScrollController scrollController = ScrollController();

  bool add = false;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
    });
    _pageController = PageController(
      initialPage: _selectedIndex,
      viewportFraction: 1.0,
    );
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

    final screenWidth = MediaQuery.of(context).size.width;

    final offset =
        (_selectedIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

    scrollController.animateTo(
      offset.clamp(0.0, scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: Visibility(
        visible: !add,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              add = !add;
            });
          },
          child: Icon(Icons.add),
        ),
      ),
      body: SizedBox(
        height: 680.h,
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height: 90,
                child: ScrollConfiguration(
                  behavior: ScrollBehavior().copyWith(
                    dragDevices: {
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.touch,
                    },
                  ),
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
                              Text(
                                _getWeekDayName(_days[index]),
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "${_days[index].day}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
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
                        "تاریخ انتخاب شده: ${date.year}/${date.month}/${date.day}",
                      ),
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: add,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFieldWidget(
                    controller: addController,
                    type: TextInputType.text,
                    hint: '...در مورد تسک خود توصیح دهید',
                    icon: Icons.send,
                    tooltip: 'توضیحات تسک',
                    onTap: () {
                      BlocProvider.of<HomeBloc>(context).add(AddToDoEvent());
                    },
                    onTextFieldTAp: () {
                      setState(() {
                        showEmoji = false;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            focusNode.unfocus();
                            FocusScope.of(context).unfocus();

                            setState(() {
                              showEmoji = !showEmoji;
                              DailyWidget.showPriority = false;
                            });
                          },
                          child: Icon(Icons.emoji_emotions_outlined),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              setState(() {
                                showEmoji = false;
                              });
                              DailyWidget.showPriority = !DailyWidget.showPriority;
                            });
                          },
                          child: Icon(Icons.flag_rounded),
                        ),
                      ),
                    ],
                  ),
                  Offstage(
                    offstage: !showEmoji,
                    child: SizedBox(
                      height: 300,
                      child: EmojiPicker(
                        onEmojiSelected: (category, emoji) {
                          addController.text += emoji.emoji;
                          addController.selection = TextSelection.fromPosition(
                            TextPosition(offset: addController.text.length),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
                visible: DailyWidget.showPriority,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          DailyWidget.showPriority = !DailyWidget.showPriority;
                        });
                        DailyWidget.priority = Colors.grey.value.toString();
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        width: 120.w,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.flag_rounded),
                            Text(
                              'معمولی',
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          DailyWidget.showPriority = !DailyWidget.showPriority;
                        });
                        DailyWidget.priority = Colors.yellow.shade600.value.toString();
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        width: 120.w,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.flag_rounded),
                            Text(
                              'کم',
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(color: Colors.yellow.shade600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          DailyWidget.showPriority = !DailyWidget.showPriority;
                        });
                        DailyWidget.priority = Colors.green.value.toString();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(8),
                        width: 120.w,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.flag_rounded),
                            Text(
                              'متوسط',
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          DailyWidget.showPriority = !DailyWidget.showPriority;
                        });
                        DailyWidget.priority = Colors.red.value.toString();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(8),
                        width: 120.w,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.flag_rounded),
                            Text(
                              'زیاد',
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
