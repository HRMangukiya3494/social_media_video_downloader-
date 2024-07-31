import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;
  final String title;

  const AppBarWidget({
    Key? key,
    required this.iconPath,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: h * 0.024,
            width: h * 0.024,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(iconPath),
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.06,
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: h * 0.024,
          ),
        ),
      ],
    );
  }
}