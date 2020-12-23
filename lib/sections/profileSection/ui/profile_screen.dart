import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/sections/profileSection/data/profile_repository.dart';
import 'package:morgadi/sections/profileSection/ui/about_morgadi.dart';
import 'package:morgadi/sections/profileSection/ui/edit_profile_screen.dart';
import 'package:morgadi/sections/profileSection/ui/open_source_licenses.dart';
import 'package:morgadi/sections/profileSection/ui/orders_screen.dart';
import 'package:morgadi/sections/profileSection/ui/privacy_policy.dart';
import 'package:morgadi/sections/profileSection/ui/terms_and_conditions.dart';
import 'package:morgadi/utils/circle_clipper.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:morgadi/utils/utility_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileRepository _repository = ProfileRepository();
  UtilityFunction _utility = UtilityFunction();

  Future<void> _launched;

  String _phone = '+919302725929';
  String _mail = 'morgadi@hotmail.com';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.yellow[100],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.yellow[100],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: screenSetUp(context),
      ),
    );
    // return Material(child: Center(child: screenSetUp()));
  }

  Widget screenSetUp(ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 8,
            right: SizeConfig.blockSizeHorizontal * 8,
            top: SizeConfig.blockSizeVertical,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Profile',
                style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 6),
              ),
              Container(
                color: Color(0xFFFF7F98),
                height: SizeConfig.blockSizeHorizontal,
                width: SizeConfig.blockSizeHorizontal * 5,
              ),
            ],
          ),
        ),
        Container(
          width: SizeConfig.screenWidth,
          color: Colors.yellow[100],
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: ClipOval(
                  clipper: CircleClipper(),
                  child: Hero(
                    tag: 'profile_image',
                    child: SvgPicture.asset(
                      "images/user_avatar.svg",
                      height: SizeConfig.blockSizeVertical * 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '${_repository.fetchUserName()}',
                style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 23.0),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)),
            child: Container(
              color: Colors.white,
              width: SizeConfig.screenWidth,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0, top: 5.0),
                child: optionsList(ctx),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget optionsList(ctx) {
    return Column(
      children: List.generate(
        profileOptionTexts.length,
        (index) => profileOption(
            profileOptionIcons[index], profileOptionTexts[index], index, ctx),
      ),
    );
  }

  Widget profileOption(IconData optionIcon, String optionText, int index, ctx) {
    return InkWell(
      onTap: () {
        onTapOperation(index, ctx);
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    color: Color(0xFFfffce6),
                    width: SizeConfig.blockSizeHorizontal * 10,
                    height: SizeConfig.blockSizeHorizontal * 10,
                    child: Icon(
                      optionIcon,
                      size: SizeConfig.blockSizeHorizontal * 5,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      optionText,
                      style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: 16.0,
                          color: Colors.black),
                    ))
              ],
            ),
            Icon(
              AntDesign.right,
              size: SizeConfig.blockSizeHorizontal * 5,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  onTapOperation(int index, ctx) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MorgadiOrders(),
        ),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute<String>(
          builder: (context) => EditProfileScreen(),
        ),
      ).then((value) => setState(() => {}));
    } else if (index == 2) {
      _helpDeskBottomSheet(ctx);
    } else if (index == 3) {
      _utility.morgadiBottomSheet(
          ctx,
          'Policies',
          List.generate(
            4,
            (index) => InkWell(
              onTap: () {
                _policyTap(index);
              },
              child: singlePolicyWidge(
                policyIcons[index],
                policyTexts[index],
              ),
            ),
          ),
          SizeConfig.blockSizeHorizontal * 5);
    }
  }

  void _helpDeskBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext bs) {
          return Container(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 3,
                vertical: SizeConfig.blockSizeVertical * 3,
              ),
              child: Wrap(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Help Desk',
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              fontSize: SizeConfig.blockSizeHorizontal * 5),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 0.5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFF7F98),
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockSizeHorizontal)),
                          height: SizeConfig.blockSizeHorizontal,
                          width: SizeConfig.blockSizeHorizontal * 5,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _launched = _openUrl('mailto:$_mail');
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Container(
                                      color: Color(0xFFfffce6),
                                      width:
                                          SizeConfig.blockSizeHorizontal * 10,
                                      height:
                                          SizeConfig.blockSizeHorizontal * 10,
                                      child: Icon(
                                        AntDesign.mail,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 5,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Email Us',
                                          style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          'morgadi@hotmail.com',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _launched = _openUrl('tel:$_phone');
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Container(
                                      color: Color(0xFFfffce6),
                                      width:
                                          SizeConfig.blockSizeHorizontal * 10,
                                      height:
                                          SizeConfig.blockSizeHorizontal * 10,
                                      child: Icon(
                                        AntDesign.phone,
                                        size:
                                            SizeConfig.blockSizeHorizontal * 5,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Call Us',
                                            style: TextStyle(
                                                fontFamily: 'Poppins-Medium',
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    4,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            '+91 9302725929',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget singlePolicyWidge(IconData icon, String text) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      color: Color(0xFFfffce6),
                      width: SizeConfig.blockSizeHorizontal * 10,
                      height: SizeConfig.blockSizeHorizontal * 10,
                      child: Icon(
                        icon,
                        size: SizeConfig.blockSizeHorizontal * 5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                                fontFamily: 'Poppins-Medium',
                                fontSize: SizeConfig.blockSizeHorizontal * 4,
                                color: Colors.black),
                          ),
                        ],
                      ))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _policyTap(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AboutMorgadi(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrivacyPolicy(),
          ),
        );
        break;
        case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TermsAndConditions(),
          ),
        );
        break;
        case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OpenSourceLicenses(),
          ),
        );
        break;
      default:
        print('Not Found');
    }
  }

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launc $url';
    }
  }
}
