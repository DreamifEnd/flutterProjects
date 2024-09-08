import 'package:flutter/material.dart';

class GuessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onCheck;
  final TextEditingController controller;

  const GuessAppBar({
    super.key,
    required this.onCheck,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: TextField(
        controller: controller,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Color(0xffF3F6F9),
          constraints: BoxConstraints(maxHeight: 35),
          contentPadding: EdgeInsets.symmetric(vertical: -10, horizontal: 10),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          hintText: "请输入0～99数字",
          hintStyle: TextStyle(fontSize: 15),
        ),
      ),
      leading: const Icon(Icons.menu, size: 30, color: Colors.black),
      actions: [
        IconButton(
            onPressed: onCheck,
            icon: const Icon(
              Icons.run_circle_outlined,
              color: Colors.blue,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
