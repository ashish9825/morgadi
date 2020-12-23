import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:morgadi/sections/profileSection/data/profile_repository.dart';
import 'package:morgadi/utils/size_config.dart';
import 'package:morgadi/utils/utility_functions.dart';

class OpenSourceLicenses extends StatelessWidget {
  ProfileRepository _profileRepository = ProfileRepository();
  UtilityFunction _utility = UtilityFunction();

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
      body: _openSourceLicensesBody(context),
    );
  }

  Widget _openSourceLicensesBody(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 8,
        right: SizeConfig.blockSizeHorizontal * 8,
        top: SizeConfig.blockSizeVertical,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Open Source Licenses',
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
              stream: _profileRepository.fetchOpenSourceLicenses(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _openSourceLicenses(
                    snapshot.data.get('data'),
                    ctx,
                  );
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

  Widget _openSourceLicenses(String openSourceData, BuildContext ctx) {
    return ListView(
      children: [
        Html(
          data: openSourceData,
          onLinkTap: (url) {
            _utility.launchUrl(ctx, url);
          },
        ),
      ],
    );
  }
}
