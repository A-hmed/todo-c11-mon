import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/model/todo_dm.dart';
import 'package:todo/ui/providers/list_provider.dart';
import 'package:todo/ui/utils/app_colors.dart';
import 'package:todo/ui/utils/app_style.dart';

class Todo extends StatelessWidget {
  final TodoDM item;

  Todo({super.key, required this.item});

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * .13,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 22),
      child: Row(
        children: [
          buildVerticalLine(context),
          const SizedBox(
            width: 24,
          ),
          buildTodoInfo(),
          SizedBox(
            width: 16,
          ),
          buildTodoState()
        ],
      ),
    );
  }

  buildVerticalLine(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * .07,
        width: 4,
        decoration: BoxDecoration(
            color: item.isDone ? Colors.green : AppColors.primary,
            borderRadius: BorderRadius.circular(10)),
      );

  buildTodoInfo() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.bottomSheetTitle.copyWith(
                  color: item.isDone ? Colors.green : AppColors.primary),
            ),
            Spacer(),
            Text(
              item.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.bodyTextStyle,
            ),
            Spacer(),
          ],
        ),
      );

  buildTodoState() => InkWell(
        onTap: () async {
          await TodoDM.userTodosCollection
              .doc(item.id)
              .update({"isDone": !item.isDone});
          listProvider.loadTodoFromFirestore();
        },
        child: item.isDone ? buildCheckedState() : buildUnCheckedState(),
      );

  Container buildCheckedState() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.primary),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        "Done",
        style: TextStyle(
            fontSize: 30,
            color: item.isDone ? Colors.green : AppColors.primary),
      ),
    );
  }

  Container buildUnCheckedState() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.primary),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Icon(
        Icons.done,
        color: AppColors.white,
        size: 30,
      ),
    );
  }
}
