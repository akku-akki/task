import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/utils/custom_size.dart';
import 'package:task/widgets/employee.dart';
import 'package:task/widgets/heyCloudy/cloudyHome.dart';
import 'package:task/widgets/userForm.dart';

import 'network/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            bodyText1: GoogleFonts.poppins(),
            bodyText2: GoogleFonts.poppins(),
            headline6: GoogleFonts.poppins(),
            headline5: GoogleFonts.poppins(),
            button: GoogleFonts.poppins(),
            subtitle2: GoogleFonts.poppins(),
            subtitle1: GoogleFonts.poppins(),
            headline4: GoogleFonts.poppins(),
            headline3: GoogleFonts.poppins()),
        primarySwatch: Colors.pink,
        accentColor: Colors.pink[300],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetworkApi api;
  @override
  void initState() {
    api = NetworkApi();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    CustomSize.initialize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Test"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserForm()));
              },
              child: Text("1. Create Form"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmployeeListView()));
              },
              child: Text("2. Fetch List"),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CloudyHome()));
              },
              child: Text("3. Cloudy"),
            ),
          ],
        ),
      ),
    );
  }
}
