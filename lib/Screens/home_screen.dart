import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:offiql/Extension/theme.dart';
import 'package:offiql/Helper/tile_loader.dart';
import 'package:offiql/Screens/add_users.dart';
import 'package:offiql/Screens/local_user.dart';
import 'package:offiql/Utils/colors.dart';
import 'package:offiql/Utils/customize_style.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Models/user_model.dart';
import '../Provider/home.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String profilePic = '';
  String userName = 'Kajal';
  String appName = "Offiql";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final userProvider = HomeProvider();
        userProvider.fetchUsers();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: context.backgroundColor,
        statusBarIconBrightness:
            context.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            OffiqlCustomizeStyle appStyle =
                OffiqlCustomizeStyle.init(constraints, orientation);
            return Scaffold(
              body: Stack(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: Container(
                          color: context.backgroundColor,
                          width: appStyle.sizes.screenWidth,
                          height: appStyle.sizes.screenHeight,
                        ),
                      ),
                      SafeArea(
                        child: Column(
                          children: [
                            // Top AppBar
                            Padding(
                              padding: appStyle.offiqlAllScreenPadding(ver: 1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom:
                                              appStyle.sizes.verticalBlockSize *
                                                  0.8,
                                          left: appStyle
                                                  .sizes.horizontalBlockSize *
                                              6,
                                          child: Text(
                                            userName,
                                            style: TextStyle(
                                                color: Color(0xff495057),
                                                fontSize: appStyle
                                                        .sizes.textMultiplier *
                                                    1.2,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              appName.substring(0, 1),
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff7209b7),
                                                  fontSize: appStyle.sizes
                                                          .textMultiplier *
                                                      4.5,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Shimmer.fromColors(
                                              baseColor: Colors.deepPurple,
                                              highlightColor:
                                                  Colors.deepPurpleAccent,
                                              period: Duration(seconds: 2),
                                              child: Text(
                                                appName.substring(1),
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xff7209b7)
                                                            .withValues(
                                                                alpha: 0.8),
                                                    fontSize: appStyle.sizes
                                                            .textMultiplier *
                                                        2.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Consumer<HomeProvider>(
                                    builder: (context, menuProvider, child) {
                                      return PopupMenuButton<String>(
                                        padding: EdgeInsets.zero,
                                        color: Colors.deepPurpleAccent.shade700,

                                        elevation: 2,
                                        // Gives the popup a shadow effect
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              appStyle.sizes
                                                      .horizontalBlockSize *
                                                  3), // Rounded corners
                                        ),
                                        popUpAnimationStyle: AnimationStyle(
                                            curve: Curves.slowMiddle,
                                            duration: const Duration(
                                                milliseconds: 200)),
                                        offset: Offset(
                                          appStyle.sizes.horizontalBlockSize *
                                              4.0,
                                          appStyle.sizes.horizontalBlockSize *
                                              12,
                                        ),
                                        onOpened: () =>
                                            menuProvider.toggleMenu(true),
                                        onCanceled: () =>
                                            menuProvider.toggleMenu(false),
                                        onSelected: (value) async {
                                          if (value == "Add Users") {
                                            menuProvider.toggleMenu(false);
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return AddUsers();
                                                },
                                                transitionsBuilder: (context,
                                                        animation,
                                                        secondaryAnimation,
                                                        child) =>
                                                    FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                ),
                                              ),
                                            );
                                          } else if (value == "Local Users") {
                                            menuProvider.toggleMenu(false);
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return LocalUser();
                                                },
                                                transitionsBuilder: (context,
                                                        animation,
                                                        secondaryAnimation,
                                                        child) =>
                                                    FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                ),
                                              ),
                                            );
                                          } else if (value == "Light" ||
                                              value == "Dark") {
                                            menuProvider.toggleMenu(false);
                                            context.toggleTheme();
                                          }
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return {
                                            context.isDarkMode
                                                ? "Light"
                                                : "Dark",
                                            "Add Users",
                                            "Local Users",
                                          }.map((String popListChoice) {
                                            return PopupMenuItem<String>(
                                              padding: appStyle
                                                  .offiqlAllScreenPadding(
                                                      ver: 2, hor: 3),
                                              value: popListChoice,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    popListChoice == "Logout"
                                                        ? Icons.logout
                                                        : popListChoice ==
                                                                "Local Users"
                                                            ? Icons.person
                                                            : popListChoice ==
                                                                    "Add Users"
                                                                ? Icons.person
                                                                : context
                                                                        .isDarkMode
                                                                    ? Icons
                                                                        .light_mode
                                                                    : Icons
                                                                        .dark_mode,
                                                    color: Colors.white,
                                                    size: appStyle.sizes
                                                            .textMultiplier *
                                                        2.5,
                                                  ),
                                                  appStyle.offiqlHorizontalGap(
                                                      horizontalGapSizeInPercent:
                                                          2.0),
                                                  Text(popListChoice,
                                                      style: appStyle
                                                          .subHeaderStyle(
                                                              color:
                                                                  Colors.white,
                                                              size: 1.5 *
                                                                  appStyle.sizes
                                                                      .textMultiplier)),
                                                ],
                                              ),
                                            );
                                          }).toList();
                                        },
                                        splashRadius: 0,
                                        child: Container(
                                          padding:
                                              appStyle.offiqlAllScreenPadding(
                                                  ver: 1, hor: 1),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                appStyle.sizes.screenWidth),
                                            color: Colors.grey.shade300,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.withValues(
                                                      alpha: context.isDarkMode
                                                          ? 0.7
                                                          : 0.3),
                                                  spreadRadius: 2,
                                                  // blurRadius: 7,
                                                  blurStyle: BlurStyle
                                                      .inner // changes position of shadow
                                                  ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              if (menuProvider.isMenuOpened)
                                                appStyle.offiqlHorizontalGap(
                                                    horizontalGapSizeInPercent:
                                                        1),
                                              if (!menuProvider.isMenuOpened)
                                                _buildProfileIcon(appStyle),
                                              if (menuProvider.isMenuOpened)
                                                _buildMenuBarIcon(appStyle),
                                              appStyle.offiqlHorizontalGap(
                                                  horizontalGapSizeInPercent:
                                                      1),
                                              if (menuProvider.isMenuOpened)
                                                _buildProfileIcon(appStyle),
                                              if (!menuProvider.isMenuOpened)
                                                _buildMenuBarIcon(appStyle),
                                              if (!menuProvider.isMenuOpened)
                                                appStyle.offiqlHorizontalGap(
                                                    horizontalGapSizeInPercent:
                                                        1),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: LiquidPullToRefresh(
                                onRefresh: HomeProvider().fetchUsers,
                                backgroundColor: Colors.white,
                                showChildOpacityTransition: false,
                                animSpeedFactor: 3.0,
                                springAnimationDurationInMilliseconds: 500,
                                color: context.isDarkMode
                                    ? Colors.deepPurpleAccent
                                    : Colors.deepPurple,
                                height: appStyle.sizes.screenHeight * 0.1,
                                child: Consumer<HomeProvider>(
                                  builder: (context, home, child) {
                                    if (home.isLoading) {
                                      return Center(
                                        child: ListShimmer(
                                          itemCount: 5,
                                          color: context.isDarkMode
                                              ? cardDark
                                              : Colors.grey,
                                        ),
                                      );
                                    }

                                    return home.users.isEmpty
                                        ? Center(
                                            child: Text("No users data found"))
                                        : ListView.builder(
                                            padding: appStyle
                                                .offiqlAllScreenPadding(),
                                            itemCount: home.users.length,
                                            itemBuilder: (context, index) {
                                              UserModel user =
                                                  home.users[index];
                                              return Container(
                                                padding: appStyle
                                                    .offiqlAllScreenPadding(
                                                        hor: 4),
                                                margin: EdgeInsets.only(
                                                    bottom: appStyle.sizes
                                                            .horizontalBlockSize *
                                                        2.5),
                                                decoration: BoxDecoration(
                                                    color:
                                                        context.backgroundColor,
                                                    borderRadius: BorderRadius
                                                        .circular(appStyle.sizes
                                                                .textMultiplier *
                                                            3.5),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: context
                                                                .isDarkMode
                                                            ? Colors.black
                                                                .withValues(
                                                                    alpha: 0.15)
                                                            : Colors.black12,
                                                        blurRadius: 3,
                                                        // offset: const Offset(0, 3),
                                                      ),
                                                    ]),
                                                child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    leading: CircleAvatar(
                                                      backgroundColor: Colors
                                                          .deepPurpleAccent,
                                                      child: Text(user.name[0],
                                                          style: appStyle
                                                              .subHeaderStyle(
                                                                  color: Colors
                                                                      .white)),
                                                    ),
                                                    title: Text(user.name,
                                                        style: appStyle
                                                            .subHeaderStyle(
                                                                size: appStyle
                                                                        .sizes
                                                                        .textMultiplier *
                                                                    1.8,
                                                                color: context
                                                                    .textColor)),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(user.email,
                                                            style: appStyle
                                                                .subHeaderStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700])),
                                                        Text(user.phone,
                                                            style: appStyle
                                                                .subHeaderStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        700])),
                                                      ],
                                                    ),
                                                    trailing: appStyle.offiqlIcon(
                                                        Icons.arrow_forward_ios,
                                                        color:
                                                            context.textColor),
                                                    onTap: () => Navigator.push(
                                                          context,
                                                          PageRouteBuilder(
                                                            pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) {
                                                              return UserDetailsScreen(
                                                                user: user,
                                                              );
                                                            },
                                                            transitionsBuilder: (context,
                                                                    animation,
                                                                    secondaryAnimation,
                                                                    child) =>
                                                                FadeTransition(
                                                              opacity:
                                                                  animation,
                                                              child: child,
                                                            ),
                                                          ),
                                                        )),
                                              );
                                            },
                                          );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProfileIcon(OffiqlCustomizeStyle appStyle) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: appStyle.sizes.textMultiplier * 4,
          maxWidth: appStyle.sizes.textMultiplier * 4),
      decoration: BoxDecoration(
          color:
              profilePic.isEmpty ? Colors.deepPurpleAccent : Colors.transparent,
          image: profilePic.isEmpty
              ? null
              : DecorationImage(
                  image: NetworkImage(profilePic), fit: BoxFit.cover),
          shape: BoxShape.circle),
      child: profilePic.isNotEmpty
          ? null
          : Center(
              child: Icon(
              Icons.person,
              color: Colors.white,
              size: appStyle.sizes.textMultiplier * 3.0,
            )),
    );
  }

  Widget _buildMenuBarIcon(OffiqlCustomizeStyle appStyle) {
    return Icon(
      Icons.menu,
      size: appStyle.sizes.textMultiplier * 3,
      color: Colors.grey,
    );
  }
}
