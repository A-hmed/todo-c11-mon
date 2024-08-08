import 'package:flutter/material.dart';
import 'package:todo/ui/screens/add_bottom_sheet/add_bottom_sheet.dart';
import 'package:todo/ui/screens/home/tabs/todos_list/todos_list.dart';
import 'package:todo/ui/screens/home/tabs/settings.dart';
import 'package:todo/ui/utils/app_colors.dart';
import 'package:todo/ui/utils/app_style.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int index = 0;

   List<Widget> screens = [TodosList() , const Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsetsDirectional.only(
            start: 30,
          ),
          child: Text(
            'ToDo app',
            style: AppStyle.appBarStyle,
          ),
        ),
      ),
      body: screens[index],
      bottomNavigationBar: buildBottomAppBar(),
      floatingActionButton: buildFab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  FloatingActionButton buildFab(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      shape: const StadiumBorder(
        side: BorderSide(width: 4 , color: AppColors.white)
      ),
      onPressed: (){
        showModalBottomSheet(context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)
            ),
            isScrollControlled: true,
            builder: (context) => Builder(
              builder: (context) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: AddBottomSheet(),
                );
              }
            ));
      },
      child: const Icon(Icons.add),
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      notchMargin: 13,
      clipBehavior: Clip.antiAlias,
      shape:const CircularNotchedRectangle() ,
      child: BottomNavigationBar(
        currentIndex: index,
        onTap: (currentIndex){
          index = currentIndex;
          setState(() {});
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: '',
              icon: Icon(
                size: 37,
                Icons.list,
          )
          ),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(
                size: 37,
                Icons.settings,
              )
          )
        ],
        selectedItemColor: AppColors.primary,
      ),
    );
  }
}
