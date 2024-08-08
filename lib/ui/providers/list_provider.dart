import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/utils/extensions.dart';

import '../model/todo_dm.dart';

class ListProvider extends ChangeNotifier {
  List<TodoDM> todos = [];

  DateTime selectedCalendarDate = DateTime.now();

  void loadTodoFromFirestore() async {
    CollectionReference todosCollection =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);
    QuerySnapshot querySnapshot = await todosCollection.get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;
    todos = docs.map((docSnapShot) {
      Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
      return TodoDM.fromJson(json);
    }).toList();
    todos = todos
        .where((todo) => selectedCalendarDate.isSameDate(todo.date))
        .toList();
    todos.sort((todo1, todo2){
      return todo1.date.compareTo(todo2.date);
    });
    notifyListeners();
  }
}
