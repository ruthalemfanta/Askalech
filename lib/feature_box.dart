import 'package:askalech/pallete.dart';
import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  const FeatureBox(
      {super.key,
      required this.color,
      required this.headerText,
      required this.descriptionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          )),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              headerText,
              style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            descriptionText,
            style: const TextStyle(
              fontFamily: 'Cera Pro',
              color: Pallete.blackColor,
            ),
          )
        ],
      ),
    );
  }
}
