import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
/// this class uses this library : intro_views_flutter
/// the link to it : https://pub.dev/packages/intro_views_flutter#-installing-tab-
class IntroViewsPage extends StatelessWidget {
  static const routeName = '/IntroViewsPage';
  /// -----------------------------------------------
  /// making list of pages needed to pass in IntroViewsFlutter constructor.
  /// -----------------------------------------------
  final pages = [
    /// -----------------------------------------------
    /// PageViewModel dart class for storing data in it
    /// -----------------------------------------------
    PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        // iconImageAssetPath: 'assets/air-hostess.png',
        /// -----------------------------------------------
        /// bubble Image for indicator.
        /// -----------------------------------------------
        bubble: Image.asset('images/casual_life.png'),
        /// -----------------------------------------------
        /// Text details.
        /// -----------------------------------------------
        body: Column(
          children: [
            Text(
              'E-learning',
              style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text(
              'Haselfree booking of flight tickets with full refund on cancelation',style: TextStyle(fontSize: 20,),
            ),
          ],
        ),
        /// -----------------------------------------------
        /// Text header .
        /// -----------------------------------------------
        // title: Text(
        //   'Homeworks and Assignments',
        // ),
        // titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        // bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        /// -----------------------------------------------
        /// Main image.
        /// -----------------------------------------------
        mainImage: Image.asset(
          'images/casual_life.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )
    ),
    PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        // iconImageAssetPath: 'assets/air-hostess.png',
        /// -----------------------------------------------
        /// bubble Image for indicator.
        /// -----------------------------------------------
        bubble: Image.asset('images/casual_life.png'),
        /// -----------------------------------------------
        /// Text details.
        /// -----------------------------------------------
        body: Column(
          children: [
            Text(
              'Celebrate the bades with your children\'s',
              style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text(
              'Haselfree booking of flight tickets with full refund on cancelation',style: TextStyle(fontSize: 20,),
            ),
          ],
        ),
        /// -----------------------------------------------
        /// Text header .
        /// -----------------------------------------------
        // title: Text(
        //   'Homeworks and Assignments',
        // ),
        // titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        // bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        /// -----------------------------------------------
        /// Main image.
        /// -----------------------------------------------
        mainImage: Image.asset(
          'images/casual_life.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )
    ),
    PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        // iconImageAssetPath: 'assets/air-hostess.png',
        /// -----------------------------------------------
        /// bubble Image for indicator.
        /// -----------------------------------------------
        bubble: Image.asset('images/business-3d.png'),
        /// -----------------------------------------------
        /// Text details.
        /// -----------------------------------------------
        body: Column(
          children: [
            Text(
              'School Announcemens',
              style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text(
              'Haselfree booking of flight tickets with full refund on cancelation',style: TextStyle(fontSize: 20,),
            ),
          ],
        ),
        /// -----------------------------------------------
        /// Text header .
        /// -----------------------------------------------
        // title: Text(
        //   'Homeworks and Assignments',
        // ),
        // titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        // bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        /// -----------------------------------------------
        /// Main image.
        /// -----------------------------------------------
        mainImage: Image.asset(
          'images/business-3d.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )
    ),
    PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        // iconImageAssetPath: 'assets/air-hostess.png',
        /// -----------------------------------------------
        /// bubble Image for indicator.
        /// -----------------------------------------------
        bubble: Image.asset('images/casual_life.png'),
        /// -----------------------------------------------
        /// Text details.
        /// -----------------------------------------------
        body: Column(
          children: [
            Text(
              'Homework and Assignments',
              style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text(
              'Haselfree booking of flight tickets with full refund on cancelation',style: TextStyle(fontSize: 20,),
            ),
          ],
        ),
        /// -----------------------------------------------
        /// Text header .
        /// -----------------------------------------------
        // title: Text(
        //   'Homeworks and Assignments',
        // ),
        // titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        // bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
        /// -----------------------------------------------
        /// Main image.
        /// -----------------------------------------------
        mainImage: Image.asset(
          'images/casual_life.png',
          height: 285.0,
          width: 285.0,
          alignment: Alignment.center,
        )
    ),
  ];
  @override
  Widget build(BuildContext context) {
    /// -----------------------------------------------
    /// Build main content with MaterialApp widget.
    /// -----------------------------------------------
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IntroViews Flutter', //title of app
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), //ThemeData
      home: Builder(
        /// -----------------------------------------------
        /// Build Into with IntroViewsFlutter widget.
        /// -----------------------------------------------
        builder: (context) => Container(
          child: IntroViewsFlutter(
            pages,
            showNextButton: true,
            showBackButton: true,
            onTapDoneButton: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Hiome_Kids(),
                ), //MaterialPageRoute
              );
            },
            pageButtonTextStyles: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}

