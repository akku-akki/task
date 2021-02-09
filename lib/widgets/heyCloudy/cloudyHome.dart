import 'package:flutter/material.dart';
import 'package:task/externalLib/carousel.dart';
import 'package:task/utils/custom_size.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/model/stories.dart';
import '../heyCloudy/widgets/PageAdd.dart';
import '../heyCloudy/widgets/storyHeadingBar.dart';
import './widgets/storyCard.dart';
import 'cloudyPlay.dart';

class CloudyHome extends StatefulWidget {
  @override
  _CloudyHomeState createState() => _CloudyHomeState();
}

class _CloudyHomeState extends State<CloudyHome> {
  CustomSize customSize = CustomSize.customSize;
  Size size;
  Stories stories;
  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    stories = Stories();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
              actions: [
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
              ],
              expandedHeight: size.height * 0.25,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Stack(
                  children: [
                    Image.asset(
                      "assets/images/home-header.png",
                      height: size.height * 0.2496,
                      scale: 1.2,
                      fit: BoxFit.cover,
                    ),
                    SvgPicture.asset(
                      "assets/images/star_premium.svg",
                      height: customSize.heightFactor * 90,
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
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: CarouselSlider(
                autoPlayCurve: Curves.linear,
                autoPlay: true,
                height: size.height * 0.28,
                items: Stories.storiesList
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlayStory(
                                          imagePath: e.imagePath,
                                          title: e.title,
                                        )));
                          },
                          child: PageAdd(
                            image: e.imagePath,
                            text: e.title,
                          ),
                        ))
                    .toList(),
                showIndicator: true,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: customSize.heightFactor * 25,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StoryHeadingBar(
                      title: "Everyday Stories",
                    ),
                    StoryList(),
                    StoryHeadingBar(
                      title: "Night Stories",
                    ),
                    StoryList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
