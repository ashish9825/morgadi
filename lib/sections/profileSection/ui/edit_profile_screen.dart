import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:morgadi/sections/profileSection/bloc/edit_profile_bloc.dart';
import 'package:morgadi/sections/profileSection/data/profile_repository.dart';
import 'package:morgadi/sections/profileSection/widgets/edit_city_dialog.dart';
import 'package:morgadi/sections/profileSection/widgets/edit_email_dialog.dart';
import 'package:morgadi/sections/profileSection/widgets/edit_name_dialog.dart';
import 'package:morgadi/sections/profileSection/widgets/edit_owncar_dialog.dart';
import 'package:morgadi/sections/profileSection/widgets/edit_phone_dialog.dart';
import 'package:morgadi/utils/circle_clipper.dart';
import 'package:morgadi/utils/size_config.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            EditProfileBloc(profileRepository: ProfileRepository()),
        child: EditProfile());
  }
}

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileRepository _repository = ProfileRepository();

  TextEditingController _nameController = TextEditingController();

  EditProfileBloc _editProfileBloc;

  @override
  void initState() {
    _editProfileBloc = BlocProvider.of<EditProfileBloc>(context);
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.yellow[100],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.yellow[100],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: screenSetUp(),
      ),
    );
  }

  Widget screenSetUp() {
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
                'Edit Profile',
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
              SizedBox(height: 25.0),
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
                child: optionsList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget optionsList() {
    return StreamBuilder(
        stream: _editProfileBloc.internetStream,
        builder: (ctxt, snap) {
          if (!snap.hasData) {
            return _loadingIndicator();
          }
          var result = snap.data;

          switch (result) {
            case DataConnectionStatus.disconnected:
              {
                return Center(
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 40,
                    width: SizeConfig.blockSizeHorizontal * 60,
                    child: Lottie.asset("assets/no_internet1.json"),
                  ),
                );
              }
            case DataConnectionStatus.connected:
              {
                return StreamBuilder<DocumentSnapshot>(
                  stream: _repository.fetchUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          _editFullName(),
                          _editPhoneNumber(
                              snapshot.data.get('phoneNo') ?? 'Unknown'),
                          _editEmail(snapshot.data.get('email') ?? 'Unknown'),
                          _editCity(snapshot.data.get('city') ?? 'Unknown'),
                          _editOwnCar(snapshot.data.get('ownCar') ?? 'Unknown'),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return _errorWidget(snapshot.error);
                    } else {
                      return _loadingIndicator();
                    }
                  },
                );
              }
            default:
              {
                return Center(
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 40,
                    width: SizeConfig.blockSizeHorizontal * 60,
                    child: Lottie.asset("assets/no_internet1.json"),
                  ),
                );
              }
          }
        });
  }

  Widget _editFullName() {
    return InkWell(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: EditNameDialog(
              editProfileBloc: _editProfileBloc,
              fullName: '${_repository.fetchUserName()}',
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 11.0,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 0.5,
                      ),
                      Text(
                        '${_repository.fetchUserName()}',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Icon(
              AntDesign.edit,
              size: SizeConfig.blockSizeHorizontal * 5,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _editPhoneNumber(String phoneNumber) {
    return InkWell(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: EditPhoneDialog(
              editProfileBloc: _editProfileBloc,
              phoneNumber: phoneNumber,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 11.0,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 0.5,
                      ),
                      Text(
                        '${_repository.fetchUserPhone()}',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Icon(
              AntDesign.edit,
              size: SizeConfig.blockSizeHorizontal * 5,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _editEmail(String email) {
    return InkWell(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: EditMailDialog(
              editProfileBloc: _editProfileBloc,
              email: email,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 11.0,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 0.5,
                      ),
                      Text(
                        '$email',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Icon(
              AntDesign.edit,
              size: SizeConfig.blockSizeHorizontal * 5,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _editCity(String city) {
    return InkWell(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: EditCityDialog(
              editProfileBloc: _editProfileBloc,
              city: city,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 11.0,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 0.5,
                      ),
                      Text(
                        '$city',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Icon(
              AntDesign.edit,
              size: SizeConfig.blockSizeHorizontal * 5,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _editOwnCar(bool ownCar) {
    return InkWell(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: EditOwnCarDialog(
              editProfileBloc: _editProfileBloc,
              ownCar: ownCar,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Own a Car ?',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 11.0,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 0.5,
                      ),
                      Text(
                        ownCar == true ? 'Yes' : 'No',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Icon(
              AntDesign.edit,
              size: SizeConfig.blockSizeHorizontal * 5,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitRipple(
            color: Colors.black,
            size: SizeConfig.blockSizeHorizontal * 20,
            borderWidth: SizeConfig.blockSizeHorizontal * 3,
          ),
        ],
      ),
    );
  }

  Widget _errorWidget(String error) {
    return Text(error.toString());
  }
}
