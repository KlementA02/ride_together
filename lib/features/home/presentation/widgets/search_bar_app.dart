import 'package:flutter/material.dart';

class SearchBarApp extends StatelessWidget implements PreferredSizeWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSubmitted;
  final TextEditingController? controller;
  final bool isLoading;
  final String? errorText;
  const SearchBarApp(
      {super.key,
      this.hintText = 'Where are you going?',
      this.onChanged,
      this.onSubmitted,
      this.controller,
      required this.isLoading,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    final borderColor = errorText != null
        ? Colors.red
        : isLoading
            ? Colors.grey
            : Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      margin: const EdgeInsets.only(top: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: borderColor),
          ),
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
