import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';


class CustomSearchBar extends StatelessWidget {
  final Function(String) onSubmit;
  final TextEditingController? controller;

  CustomSearchBar({required this.onSubmit,this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: TextField(
        maxLength: 30,
        onSubmitted: onSubmit,
        controller: controller,
        keyboardType: TextInputType.text,
        cursorColor: Theme.of(context).dividerColor,
        style: TextStyle(
          fontSize: 15.0,
          color: Theme.of(context).dividerColor,
          fontWeight: FontWeight.w500
        ),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              width: 2.0,
              color: Theme.of(context).dividerColor
            )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor
            )
          ),
          hintText: " Search ...",
          hintStyle: const TextStyle(
            fontSize: 15.0
          ),
          suffixIcon: const Icon(Icons.search),
          suffixIconColor: Theme.of(context).dividerColor
        ),
      ),
    );
  }
}
