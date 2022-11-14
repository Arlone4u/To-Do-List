class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Buy Bread', isDone: true),
      ToDo(id: '02', todoText: 'Read Notes'),
      ToDo(id: '03', todoText: 'Water the Plants', isDone: true),
      ToDo(id: '04', todoText: 'Attend Meeting'),
      ToDo(id: '05', todoText: 'Check Emails'),
      ToDo(id: '06', todoText: 'Dinner with Fam'),
    ];
  }
}
