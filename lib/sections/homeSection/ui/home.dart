import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:morgadi/sections/carBuySellSection/ui/car_buy_sell_screen.dart';
import 'package:morgadi/sections/carMortgageSection/ui/car_mortgage_screen.dart';
import 'package:morgadi/sections/carRentSection/ui/rent_screen.dart';
import 'package:morgadi/sections/carRepairSection/ui/car_repair_screen.dart';
import 'package:morgadi/sections/carSparesAccessories/ui/car_spares_screen.dart';
import 'package:morgadi/sections/homeSection/bloc/home_bloc.dart';
import 'package:morgadi/sections/homeSection/model/morgadi_services.dart';
import 'package:morgadi/sections/homeSection/ui/conatct_mail.dart';
import 'package:morgadi/sections/profileSection/ui/profile_screen.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:morgadi/sections/homeSection/data/home_repository.dart';
import 'package:morgadi/main.dart';
import 'package:morgadi/sections/authenticate/data/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morgadi/sections/authenticate/bloc/bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<MorgadiServices> morgadiServices = List<MorgadiServices>();
  HomeRepository _homeRepository = HomeRepository();

  String _phone = '+919302725929';

  @override
  void initState() {
    addServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Material(
        child: SafeArea(
          child: ListView(
            children: [
              _homeBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _helloMessage(),
        _greetingBody(),
        _serviceWidgets(),
        _contactWidgets(),
        _endNote(),
      ],
    );
  }

  Widget _greetingBody() {
    return Container(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 3,
          right: SizeConfig.blockSizeHorizontal * 3,
          top: SizeConfig.blockSizeVertical * 2),
      child: Container(
        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 2,
            top: SizeConfig.blockSizeVertical,
            bottom: SizeConfig.blockSizeVertical),
        decoration: BoxDecoration(
          color: homeBloc.getTimeColor(),
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeBloc.getCurrentTime(),
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 6,
                        color: Colors.white),
                  ),
                  Container(
                    // color: Color(0xFFFF7F98),
                    color: Colors.yellow[100],
                    height: SizeConfig.blockSizeHorizontal,
                    width: SizeConfig.blockSizeHorizontal * 5,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  ),
                  Text(
                    homeBloc.getCurrentDay(),
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 5,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                height: SizeConfig.blockSizeVertical * 20,
                width: SizeConfig.blockSizeHorizontal * 50,
                child: Container(
                  height: SizeConfig.blockSizeVertical * 40,
                  width: SizeConfig.blockSizeHorizontal * 60,
                  child: Lottie.asset(homeBloc.getTimeIllustration()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _helloMessage() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      },
      child: Container(
        padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 3,
          right: SizeConfig.blockSizeHorizontal * 3,
          top: SizeConfig.blockSizeVertical * 2,
        ),
        child: Row(
          children: [
            Hero(
              tag: 'profile_image',
              child: SvgPicture.asset(
                "images/user_avatar.svg",
                height: SizeConfig.blockSizeVertical * 6,
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 2,
            ),
            Text(
              'Hi, ${homeBloc.getDisplayName().split(" ").first} !',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _serviceWidgets() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 3,
          vertical: SizeConfig.blockSizeVertical * 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
            style: TextStyle(
                color: Colors.grey,
                fontSize: SizeConfig.blockSizeHorizontal * 5),
          ),
          Column(
            children: List.generate(
              morgadiServices.length,
              (index) => singleService(
                morgadiServices[index],
                widgetTransition(index),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget singleService(
      MorgadiServices morgadiServices, Widget transitionWidget) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => transitionWidget));
      },
      child: Container(
        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 2,
            top: SizeConfig.blockSizeHorizontal,
            bottom: SizeConfig.blockSizeHorizontal),
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    morgadiServices.service,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 5),
                  ),
                  Container(
                    color: Color(0xFFFF7F98),
                    height: SizeConfig.blockSizeHorizontal,
                    width: SizeConfig.blockSizeHorizontal * 5,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                height: SizeConfig.blockSizeVertical * 15,
                width: SizeConfig.blockSizeHorizontal * 40,
                child: Hero(
                  tag: morgadiServices.service,
                  child: SvgPicture.asset(
                    morgadiServices.image,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addServices() {
    for (int i = 0; i < 5; i++) {
      morgadiServices.add(MorgadiServices(serviceNames[i], serviceImages[i]));
    }
  }

  Widget widgetTransition(int index) {
    if (index == 0) {
      return CarRentScreen();
    } else if (index == 1) {
      return CarBuySellScreen();
    } else if (index == 2) {
      return CarRepairScreen();
    } else if (index == 3) {
      return CarMortgageScreen();
    } else {
      return CarSparesScreen();
    }
  }

  Widget _contactWidgets() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Help & Support',
            style: TextStyle(
                color: Colors.grey,
                fontSize: SizeConfig.blockSizeHorizontal * 5),
          ),
          Column(
            children: List.generate(
              2,
              (index) => _contactOption(contactIcons[index],
                  contactTexts[index], contactSubTexts[index], index),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
        ],
      ),
    );
  }

  Widget _contactOption(IconData contactIcon, String contactText,
      String contactSubText, int index) {
    return InkWell(
      onTap: () {
        _contactTap(index);
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  color: Color(0xFFfffce6),
                  width: SizeConfig.blockSizeHorizontal * 10,
                  height: SizeConfig.blockSizeHorizontal * 10,
                  child: Icon(
                    contactIcon,
                    size: SizeConfig.blockSizeHorizontal * 5,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contactText,
                      style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: SizeConfig.blockSizeHorizontal * 3,
                          color: Colors.black),
                    ),
                    Text(
                      contactSubText,
                      style: TextStyle(
                          fontFamily: 'Poppins-Medium',
                          fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _endNote() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          Text(
            'Copyright © 2020 Morgadi.',
            style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 2.5,
              color: Color(0xFF4d4d4d),
            ),
          ),
          Text(
            'All Rights Reserved.',
            style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 2.5,
              color: Color(0xFF4d4d4d),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          InkWell(
            onTap: () async {
              await _homeRepository.signOut();
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());

              Future.delayed(Duration.zero, () {
                Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(pageBuilder: (BuildContext context,
                        Animation animation, Animation secondaryAnimation) {
                      return MorgadiApp(
                        userRepository: UserRepository(),
                      );
                    }, transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                                begin: const Offset(1.0, 0.0), end: Offset.zero)
                            .animate(animation),
                        child: child,
                      );
                    }),
                    (route) => false);
              });
            },
            child: Text(
              'Log Out',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4,
                color: Color(0xFF4d4d4d),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
        ],
      ),
    );
  }

  void _contactTap(int index) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactMail(),
        ),
      );
    } else {
      _openUrl('tel:$_phone');
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
