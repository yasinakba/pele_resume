import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pele_resume/src/feature_home_screen/presentation/widget/app_dialog.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: 360.w,
            height: 50.h,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Text(
                          'data',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    },
                  ),
                ),
                FloatingActionButton(onPressed: () {
                  AppDialog.show(
                    child: SizedBox(
                      width: 350,
                      height: 400,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: 20,
                        itemBuilder: (_, index) => Card(
                          child: Center(child: Text('$index')),
                        ),
                      ),
                    ),
                  );
                }, child: Icon(Icons.add)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
