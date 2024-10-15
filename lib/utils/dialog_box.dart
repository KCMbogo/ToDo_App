// utils/dialog_box.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:to_do/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key, 
    required this.controller, 
    required this.onSave, 
    required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input 
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)), hintText: "Add New Task"),
            ),

            // buttons -> save & cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              // save btn
              MyButton(text: "Save", onPressed: onSave),

              const SizedBox(width: 8),

              // cancel btn
              MyButton(text: "Cancel", onPressed: onCancel)
            ],)
            
          ],
        ),
      ),
    );
  }
}