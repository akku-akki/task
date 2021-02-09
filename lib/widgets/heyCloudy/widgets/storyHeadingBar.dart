import 'package:flutter/material.dart';
import 'package:task/utils/custom_size.dart';

class StoryHeadingBar extends StatelessWidget {
  const StoryHeadingBar({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple,
          ),
          SizedBox(
            width: CustomSize.customSize.widthFactor * 16,
          ),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: CustomSize.customSize.widthFactor * 18),
          )
        ],
      ),
    );
  }
}
