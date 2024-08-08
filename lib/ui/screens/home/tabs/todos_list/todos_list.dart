import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/screens/home/tabs/todos_list/todo.dart';
import 'package:todo/ui/utils/app_colors.dart';
import 'package:todo/ui/utils/app_style.dart';
import 'package:todo/ui/utils/extensions.dart';

import '../../../../model/todo_dm.dart';

class TodosList extends StatefulWidget {
  TodosList({super.key});

  @override
  State<TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  late ListProvider listProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// This block is called after build and it is only called only once
       listProvider.loadTodoFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);

    return Column(
      children: [
        buildCalendar(),
        Expanded(
          flex: 75,
          child: ListView.builder(
              itemCount: listProvider.todos.length,
              itemBuilder: (context, index) {
                return Todo(
                  item: listProvider.todos[index],
                );
              }),
        )
      ],
    );
  }

  Expanded buildCalendar() {
    return Expanded(
      flex: 25,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                color: AppColors.primary,
              )),
              Expanded(
                  child: Container(
                color: AppColors.bgColor,
              ))
            ],
          ),
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            focusDate: listProvider.selectedCalendarDate,
            lastDate: DateTime.now().add(Duration(days: 365)),
            itemBuilder: (context, date, isSelected, onDateTapped) {
              return InkWell(
                onTap: () {
                  setState(() {
                    listProvider.selectedCalendarDate = date;
                    listProvider.loadTodoFromFirestore();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22)),
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        date.dayName,
                        style: isSelected
                            ? AppStyle.selectedCalendarDayStyle
                            : AppStyle.unSelectedCalendarDayStyle,
                      ),
                      Spacer(),
                      Text(
                        date.day.toString(),
                        style: isSelected
                            ? AppStyle.selectedCalendarDayStyle
                            : AppStyle.unSelectedCalendarDayStyle,
                      ),
                      Spacer()
                    ],
                  ),
                ),
              );
            },
            onDateChange: (selectedDate) {
              setState(() {
                listProvider.selectedCalendarDate = selectedDate;
              });
            },
          ),
        ],
      ),
    );
  }

  void onDateTapped() {}
}
