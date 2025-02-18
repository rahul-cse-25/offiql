import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:offiql/Extension/theme.dart';
import 'package:offiql/Models/user_model.dart';

import '../Utils/customize_style.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserModel user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  OffiqlCustomizeStyle appStyle = OffiqlCustomizeStyle();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.deepPurpleAccent,
        statusBarIconBrightness:
            context.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: context.backgroundColor,
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
        backgroundColor: Colors.deepPurpleAccent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: appStyle.sizes.verticalBlockSize * 10,
                margin: EdgeInsets.only(
                    bottom: appStyle.sizes.verticalBlockSize * 8),
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: appStyle.offiqlAllScreenPadding(ver: 2, hor: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.backgroundColor,
                  ),
                  child: Container(
                    width: appStyle.sizes.verticalBlockSize * 14,
                    height: appStyle.sizes.verticalBlockSize * 14,
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
                        widget.user.name[0],
                        style: TextStyle(
                            fontSize: appStyle.sizes.textMultiplier * 8.0,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: appStyle.offiqlAllScreenPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfo("Name", widget.user.name),
                _buildUserInfo("Username", widget.user.username),
                _buildUserInfo("Email", widget.user.email),
                _buildUserInfo("Phone", widget.user.phone),
                _buildUserInfo("Website", widget.user.website),
                Divider(),
                _buildUserInfo("Company", widget.user.company['name'] ?? ''),
                _buildUserInfo(
                    "Catchphrase", widget.user.company["catchPhrase"] ?? ''),
                Divider(),
                _buildUserInfo("Address",
                    "${widget.user.address.street}, ${widget.user.address.suite}, ${widget.user.address.city} - ${widget.user.address.zipcode}"),
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
