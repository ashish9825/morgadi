import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:morgadi/utils/size_config.dart';
import 'package:morgadi/utils/string_extension.dart';

class RentOrderDialog extends StatelessWidget {
  RentOrderDialog(this.doc);

  final QueryDocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 1.5,
        bottom: SizeConfig.blockSizeVertical * 1.5,
        left: SizeConfig.blockSizeHorizontal * 4,
        right: SizeConfig.blockSizeHorizontal * 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 50,
                child: Text(
                  '${doc.get('carName')}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style:
                      TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color: Colors.black, fontFamily: "Poppins-Medium"),
                      children: <TextSpan>[
                        TextSpan(
                            text: '${doc.get('distance')}',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        TextSpan(text: ' kms '),
                      ]),
                ),
              ),
            ],
          ),
          Container(
            color: Color(0xFFFF7F98),
            height: SizeConfig.blockSizeHorizontal,
            width: SizeConfig.blockSizeHorizontal * 5,
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 3),
          Center(
            child: Text(
              '${doc.get('status')}'.capitalize(),
              style: TextStyle(
                color: (doc.get('status').toString().toLowerCase() == 'pending')
                    ? Color(0xFFff5050)
                    : Color(0xFF00cc99),
                fontSize: SizeConfig.blockSizeHorizontal * 3,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          Center(
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontFamily: "Poppins-Medium"),
                  children: <TextSpan>[
                    TextSpan(
                        text: '${doc.get('source')}',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    TextSpan(text: ' -> '),
                    TextSpan(
                        text: '${doc.get('destination')}',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ]),
            ),
          ),
          Center(
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Colors.black, fontFamily: "Poppins-Medium"),
                  children: <TextSpan>[
                    TextSpan(text: '₹ '),
                    TextSpan(
                        text: '${doc.get('price')}',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ]),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Boarding Date',
                    style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: SizeConfig.blockSizeHorizontal * 2.5),
                  ),
                  Text('${doc.get('date')}'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Boarding Time',
                    style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: SizeConfig.blockSizeHorizontal * 2.5),
                  ),
                  Text('${doc.get('time')}'),
                ],
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 20,
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 2,
                        vertical: SizeConfig.blockSizeVertical * 1),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeHorizontal * 2),
                    ),
                    child: Center(
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
