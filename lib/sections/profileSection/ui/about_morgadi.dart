import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:morgadi/sections/profileSection/data/profile_repository.dart';
import 'package:morgadi/utils/size_config.dart';

class AboutMorgadi extends StatelessWidget {
  ProfileRepository _profileRepository = ProfileRepository();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _aboutMorgadiBody(),
    );
  }

  Widget _aboutMorgadiBody() {
    return  Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 8,
          right: SizeConfig.blockSizeHorizontal * 8,
          top: SizeConfig.blockSizeVertical,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Us',
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 6),
            ),
            Container(
              color: Color(0xFFFF7F98),
              height: SizeConfig.blockSizeHorizontal,
              width: SizeConfig.blockSizeHorizontal * 5,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Expanded(
                          child: StreamBuilder<DocumentSnapshot>(
                stream: _profileRepository.fetchAboutMorgadi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _aboutMorgadi(snapshot.data.get('data'));
                  } else if (snapshot.hasError) {
                    return _errorWidget(snapshot.error);
                  } else {
                    return _loadingIndicator();
                  }
                },
              ),
            ),
          ],
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

  Widget _aboutMorgadi(String aboutMorgadiData) {
    return ListView(
      children: [
        Html(data: aboutMorgadiData),
      ],
    );
  }
}
