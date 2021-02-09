import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/utils/custom_size.dart';

import 'widgets/storyCard.dart';

class PlayStory extends StatelessWidget {
  final String imagePath;
  final String title;
  PlayStory({Key key, this.imagePath, this.title}) : super(key: key);

  bool play = false;
  ValueNotifier<bool> playNotifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              shadowColor: Colors.white,
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              titleSpacing: 0,
              expandedHeight: size.height * 0.25,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      imagePath,
                      height: size.height * 0.2496,
                      scale: 1.2,
                      fit: BoxFit.cover,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          "assets/images/cloud-header.png",
                          fit: BoxFit.fitWidth,
                        ))
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    Text(
                      ' "$title" ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: CustomSize.customSize.widthFactor * 18,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ColumnIconsLeft(
                          path1: "assets/images/ic_close.svg",
                          path2: "assets/images/download_unsubscribed.svg",
                        ),
                        GestureDetector(
                          onTap: () {
                            playNotifier.value = play == false ? true : false;
                            play = playNotifier.value;
                          },
                          child: ValueListenableBuilder<bool>(
                              valueListenable: playNotifier,
                              builder: (context, value, _) {
                                return value == false
                                    ? SvgPicture.asset(
                                        "assets/images/ic_play.svg",
                                        width:
                                            CustomSize.customSize.widthFactor *
                                                90,
                                      )
                                    : SvgPicture.asset(
                                        "assets/images/ic_pause.svg",
                                        width:
                                            CustomSize.customSize.widthFactor *
                                                90,
                                      );
                              }),
                        ),
                        ColumnIconsRight(
                          path1: "assets/images/ic_star.svg",
                          path2: "assets/images/ic_share.svg",
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("00:01"),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            trackHeight:
                                CustomSize.customSize.heightFactor * 8),
                        child: Slider(
                          inactiveColor: Colors.grey,
                          min: 0.0,
                          max: 5.0,
                          value: 0.0,
                          onChanged: (value) {},
                          activeColor: Colors.cyan[300],
                        ),
                      ),
                    ),
                    Text("05:00"),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Image.asset("assets/images/story-bottom-cloud.png"),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            ),
            SliverToBoxAdapter(
              child: StoryList(),
            )
          ],
        ),
      ),
    );
  }
}

class ColumnIconsRight extends StatelessWidget {
  const ColumnIconsRight({
    Key key,
    this.isLeft,
    this.path1,
    this.path2,
  }) : super(key: key);

  final bool isLeft;
  final String path1;
  final String path2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SvgPicture.asset(
          path1,
          width: CustomSize.customSize.widthFactor * 70,
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            SvgPicture.asset(path2),
            SizedBox(
              width: CustomSize.customSize.widthFactor * 35,
            ),
          ],
        ),
      ],
    );
  }
}

class ColumnIconsLeft extends StatelessWidget {
  const ColumnIconsLeft({
    Key key,
    this.isLeft,
    this.path1,
    this.path2,
  }) : super(key: key);

  final bool isLeft;
  final String path1;
  final String path2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(path1),
        SizedBox(
          height: CustomSize.customSize.heightFactor * 8,
        ),
        Row(
          children: [
            SizedBox(
              width: CustomSize.customSize.widthFactor * 35,
            ),
            SvgPicture.asset(path2),
          ],
        ),
      ],
    );
  }
}
