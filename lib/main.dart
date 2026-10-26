import 'package:flutter/material.dart';
import 'package:tododododo/screen/todo_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoNewst(),);
  }
}