import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_toggle_animated/flutter_toggle_animated.dart';
import 'package:task/utils/custom_size.dart';
import 'package:task/model/stories.dart';
import 'package:task/widgets/heyCloudy/cloudyPlay.dart';

class StoryList extends StatefulWidget {
  @override
  _StoryListState createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Stories.storiesList.length,
        itemBuilder: (context, index) {
          return StoryCard(
            size: MediaQuery.of(context).size,
            customSize: CustomSize.customSize,
            imagePath: Stories.storiesList[index].imagePath,
            title: Stories.storiesList[index].title,
            isLocked: Stories.storiesList[index].isPremium,
          );
        },
      ),
    );
  }
}

class StoryCard extends StatefulWidget {
  StoryCard({
    Key key,
    @required this.size,
    @required this.customSize,
    this.imagePath,
    this.title,
    this.isLocked,
  }) : super(key: key);

  final Size size;
  final CustomSize customSize;
  final String imagePath;
  final String title;
  final bool isLocked;

  @override
  _StoryCardState createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard>
    with SingleTickerProviderStateMixin {
  ToggleController _animatedController;

  @override
  void initState() {
    _animatedController = ToggleController(
      vsync: this,
      animationDuration: const Duration(milliseconds: 100),
    );
    super.initState();
  }

  void _close() {
    if (_animatedController.isOpen() || _animatedController.isOpening())
      _animatedController.close();
  }

  void _open() {
    if (_animatedController.isClosed() || _animatedController.isClosing())
      _animatedController.open();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _open();
      },
      onTapUp: (_) {
        _close();
      },
      onTapCancel: () {
        _close();
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayStory(
                      imagePath: widget.imagePath,
                      title: widget.title,
                    )));
      },
      child: AnimatedBuilder(
        animation: _animatedController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 - (_animatedController.currentPercentOpen * 0.35),
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(12),
          width: widget.size.width * 0.43,
          height: widget.size.height * 0.35,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: widget.size.height * 0.225,
                    margin: EdgeInsets.only(
                        bottom: CustomSize.customSize.heightFactor * 21),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.imagePath),
                          scale: 1.5,
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Text(
                    "${widget.title}",
                    style: TextStyle(
                      fontSize: CustomSize.customSize.widthFactor*17,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              widget.isLocked
                  ? Positioned(
                      top: 10,
                      left: 10,
                      child: Image.asset(
                        "assets/images/lock-1.png",
                        width: CustomSize.customSize.widthFactor * 28,
                      ))
                  : SizedBox(),
              Positioned(
                width: MediaQuery.of(context).size.width / 2.4,
                bottom: widget.customSize.heightFactor * 61,
                child: SvgPicture.asset(
                  "assets/images/ic_play.svg",
                  height: CustomSize.customSize.heightFactor * 80,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }
}
