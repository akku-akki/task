
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/utils/custom_size.dart';

class PageAdd extends StatelessWidget {
  final String image;
  final String text;
  const PageAdd({
    Key key,
    this.image,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width * 300;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal:CustomSize.customSize.widthFactor* 12),
          padding: EdgeInsets.symmetric(horizontal:CustomSize.customSize.widthFactor* 16),
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 3.0,
                    color: Colors.black,
                  ),
                ],
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding:
                EdgeInsets.only(left: CustomSize.customSize.heightFactor * 25),
            child: SvgPicture.asset(
              "assets/images/ic_play.svg",
              height: CustomSize.customSize.heightFactor * 80,
            ),
          ),
        )
      ],
    );
  }
}
