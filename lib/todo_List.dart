import 'package:flutter/material.dart';
import 'package:midterm_todolist/palette.dart';
import 'package:midterm_todolist/toDo.dart';

class ToDoList extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoList(
      {Key? key,
      required this.todo,
      required this.onToDoChanged,
      this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: ListTile(
            onTap: () {
              onToDoChanged(todo);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tileColor: paletteWhite,
            leading: Icon(
              todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              color: paletteBlue,
            ),
            title: Text(
              todo.todoText!,
              style: TextStyle(
                  fontSize: 16,
                  color: paletteBlack,
                  decoration: todo.isDone ? TextDecoration.lineThrough : null),
            ),
            trailing: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: paletteRed,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                icon: Icon(Icons.delete),
                color: paletteWhite,
                iconSize: 15,
                onPressed: () {
                  onDeleteItem(todo.id);
                },
              ),
            )));
  }
}
