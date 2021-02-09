class Stories {
  String title;
  String imagePath;
  bool isPremium;

  Stories({this.title, this.imagePath, this.isPremium});


  static List<Stories> storiesList = [
  Stories(imagePath: "assets/story/caveMan.png",isPremium: true,title: "Historic Family"),
  Stories(imagePath: "assets/story/road-trip.png",isPremium: false,title: "Happy Journey"),
  Stories(imagePath: "assets/story/space.jpg",isPremium: true, title: "A Night at Moon"),
  Stories(imagePath: "assets/story/squirrel.jpg",isPremium: false, title: "Winter Tales"),
];
}


