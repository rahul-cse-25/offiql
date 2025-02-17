import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:offiql/Extension/theme.dart';

import '../Utils/customize_style.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  OffiqlCustomizeStyle appStyle = OffiqlCustomizeStyle();

  final Map<String, dynamic> userData = {
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {"lat": "-37.3159", "lng": "81.1496"}
    },
    "phone": "1-770-736-8031 x56442",
    "website": "hildegard.org",
    "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
    }
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: context.backgroundColor,
        statusBarIconBrightness:
            context.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: appStyle.offiqlIcon(Icons.arrow_back,
              color: context.textColor,
              sizeOfIcon: appStyle.sizes.textMultiplier * 3.0),
        ),
        title: Text(
          'User Details',
          style: appStyle.subHeaderStyle(
            size: appStyle.sizes.textMultiplier * 2.5,
            fontWeight: FontWeight.bold,
            color: context.textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: context.backgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            color: context.backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: appStyle.sizes.imageSizeMultiplier * 25,
                  height: appStyle.sizes.imageSizeMultiplier * 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.purpleAccent,
                        Colors.deepPurpleAccent,
                        Colors.deepPurple,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      userData["name"][0],
                      style: TextStyle(
                          fontSize: appStyle.sizes.textMultiplier * 3.2,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                    height: appStyle.sizes
                        .getVerticalGapSize(verticalGapSizeInPercent: 2)),
                Padding(
                  padding: appStyle.offiqlAllScreenPadding(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserInfo("Name", userData["name"]),
                      _buildUserInfo("Username", userData["username"]),
                      _buildUserInfo("Email", userData["email"]),
                      _buildUserInfo("Phone", userData["phone"]),
                      _buildUserInfo("Website", userData["website"]),
                      Divider(),
                      _buildUserInfo("Company", userData["company"]["name"]),
                      _buildUserInfo(
                          "Catchphrase", userData["company"]["catchPhrase"]),
                      Divider(),
                      _buildUserInfo("Address",
                          "${userData["address"]["street"]}, ${userData["address"]["suite"]}, ${userData["address"]["city"]} - ${userData["address"]["zipcode"]}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(String title, String value) {
    return Padding(
      padding: appStyle.offiqlAllScreenPadding(hor: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: appStyle.subHeaderStyle(
              size: appStyle.sizes.textMultiplier * 2.2,
              fontWeight: FontWeight.bold,
              color: context.textColor,
            ),
          ),
          Text(
            value,
            style: appStyle.subHeaderStyle(
              size: appStyle.sizes.textMultiplier * 1.8,
              color: context.textColor.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
