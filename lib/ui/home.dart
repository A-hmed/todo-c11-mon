import 'package:flutter/material.dart';
import 'package:todo/ui/tabs/note_screen.dart';
import 'package:todo/ui/tabs/settings.dart';
import 'package:todo/ui/utils/app_colors.dart';
import 'package:todo/ui/utils/app_style.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "home";
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int index = 0;

   List<Widget> screens = [NotesScreen() , Settings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: AppBar(
          elevation: 0,
        ) ,
        elevation: 0,
        centerTitle: false,
        title: Padding(
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
      bottomNavigationBar: BottomAppBar(
        notchMargin: 13,
        clipBehavior: Clip.antiAlias,
        shape:CircularNotchedRectangle() ,
        child: BottomNavigationBar(
          onTap: (currentIndex){
            index = currentIndex;
            setState(() {

            });

          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: [
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: StadiumBorder(
          side: BorderSide(width: 4 , color: AppColors.white)
        ),
        onPressed: (){},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
