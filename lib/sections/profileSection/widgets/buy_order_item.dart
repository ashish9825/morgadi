import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/utils/size_config.dart';

class BuyOrderItem extends StatelessWidget {
  BuyOrderItem(this.doc);

  final QueryDocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 1,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 1.5),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(SizeConfig.blockSizeHorizontal * 3),
                      bottomLeft:
                          Radius.circular(SizeConfig.blockSizeHorizontal * 3)),
                  color: Color(0xFFFF7F98),
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2,
                      top: SizeConfig.blockSizeHorizontal,
                      bottom: SizeConfig.blockSizeHorizontal),
                  child: Row(
                    children: [
                      Container(
                        child: SvgPicture.asset(
                          "images/car_buy_sell.svg",
                          height: SizeConfig.blockSizeVertical * 7,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              doc.get('status'),
                              style: TextStyle(
                                color: (doc
                                            .get('status')
                                            .toString()
                                            .toLowerCase() ==
                                        'pending')
                                    ? Color(0xFFff5050)
                                    : Color(0xFF00cc99),
                                fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical,
                            ),
                            Text('${doc.get('car')} ${doc.get('model')}'),
                            Text(
                              'Origin Year : ${doc.get('originYearRange')}',
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
