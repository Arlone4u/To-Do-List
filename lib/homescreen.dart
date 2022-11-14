import 'package:flutter/material.dart';
import 'package:midterm_todolist/palette.dart';
import 'package:midterm_todolist/todo_List.dart';
import 'package:midterm_todolist/toDo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final yourToDos = ToDo.todoList();
  final toDoController = TextEditingController();
  List<ToDo> searchToDO = [];

  @override
  void initState() {
    searchToDO = yourToDos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: paletteTealShade700,
        appBar: toBuildAppBar(),
        drawer: toBuildDrawer(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30, bottom: 20),
                          child: Text(
                            'Your To-Do List',
                            style: TextStyle(
                              color: paletteTealAccent,
                              fontFamily: 'Roboto',
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        for (ToDo todo in searchToDO.reversed)
                          ToDoList(
                            todo: todo,
                            onToDoChanged: handleToDoChange,
                            onDeleteItem: deleteToDoItem,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: paletteWhite,
                        boxShadow: const [
                          BoxShadow(
                            color: paletteGrey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: toDoController,
                        decoration: InputDecoration(
                          hintText: 'Add Item to your List',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      onPressed: () {
                        addToDoItem(toDoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: paletteTealShade900,
                        minimumSize: Size(60, 60),
                        elevation: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void handleToDoChange(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  void deleteToDoItem(String id) {
    setState(() {
      yourToDos.removeWhere((item) => item.id == id);
    });
  }

  void addToDoItem(String toDo) {
    setState(() {
      yourToDos.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    toDoController.clear();
  }

  void searchYourToDo(String enterKeyword) {
    List<ToDo> results = [];
    if (enterKeyword.isEmpty) {
      results = yourToDos;
    } else {
      results = yourToDos
          .where((item) =>
              item.todoText!.toLowerCase().contains(enterKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      searchToDO = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: paletteWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => searchYourToDo(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.search,
            color: paletteBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: paletteGrey),
        ),
      ),
    );
  }

  AppBar toBuildAppBar() {
    return AppBar(
      backgroundColor: paletteTealShade300,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('images/profile1.jpg'),
            ),
          )
        ],
      ),
    );
  }
}

Drawer toBuildDrawer() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: paletteTealShade300),
          accountName: Text(
            "John Doe",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Text(
            "john.doe@gmail.com",
            style: TextStyle(
              fontFamily: 'Roboto',
              //  fontWeight: FontWeight.bold,
            ),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('images/profile1.jpg'),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.notifications,
          ),
          title: const Text('Notifications'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.bug_report,
          ),
          title: const Text('Report an issue'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.favorite,
          ),
          title: const Text('Favorites'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
          ),
          title: const Text('Settings'),
          onTap: () {},
        ),
        const Divider(color: paletteBlack),
        ListTile(
          leading: Icon(
            Icons.logout,
          ),
          title: const Text('Log out'),
          onTap: () {},
        ),
      ],
    ),
  );
}
