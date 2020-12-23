import 'package:flutter/material.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactMail extends StatefulWidget {
  @override
  _ContactMailState createState() => _ContactMailState();
}

class _ContactMailState extends State<ContactMail> {
  final String _recipentEmail = 'ashishpanjwani25@live.com';
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _messageController.text,
      subject: _subjectController.text,
      recipients: [_recipentEmail],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

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
      body: _mailBody(),
    );
  }

  Widget _mailBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 8,
          right: SizeConfig.blockSizeHorizontal * 8,
          top: SizeConfig.blockSizeVertical,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mail Us',
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 6),
                ),
                Container(
                  color: Color(0xFFFF7F98),
                  height: SizeConfig.blockSizeHorizontal,
                  width: SizeConfig.blockSizeHorizontal * 5,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            _queryBody(),
          ],
        ),
      ),
    );
  }

  Widget _queryBody() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.blockSizeHorizontal * 3,
          SizeConfig.blockSizeVertical * 3,
          SizeConfig.blockSizeHorizontal * 3,
          SizeConfig.blockSizeHorizontal * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subject',
          ),
          TextFormField(
            controller: _subjectController,
            cursorColor: Colors.black,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              counter: Container(),
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
          Text(
            'Message',
          ),
          TextFormField(
            controller: _messageController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.multiline,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            maxLines: 8,
            maxLength: 1000,
            decoration: numberTextDecoration.copyWith(
              contentPadding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 1.4,
                  horizontal: SizeConfig.safeBlockHorizontal * 2.8),
              counter: Container(),
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 6,
          ),
          Center(
            child: InkWell(
              onTap: () {
                send();
              },
             child: Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 1.5),
                    child: Text(
                      'Ask For Help',
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                          color: Colors.white),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
