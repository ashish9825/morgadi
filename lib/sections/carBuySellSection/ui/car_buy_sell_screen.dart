import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morgadi/sections/carBuySellSection/widgets/buy_car.dart';
import 'package:morgadi/sections/carBuySellSection/widgets/sell_car.dart';
import 'package:morgadi/utils/size_config.dart';

class CarBuySellScreen extends StatefulWidget {
  @override
  _CarBuySellScreenState createState() => _CarBuySellScreenState();
}

class _CarBuySellScreenState extends State<CarBuySellScreen>  {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      // ),
      body: _buySellBody(),
    );
  }

  Widget _buySellBody() {
    var flexibleSpaceWidget = SliverAppBar(
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(),
      ),
      expandedHeight: SizeConfig.blockSizeVertical*45,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: _headerWidget(),
      ),
      bottom: TabBar(
        tabs: [
          Tab(
            child: Container(
              width: SizeConfig.blockSizeHorizontal*20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      SizeConfig.blockSizeHorizontal * 10)),
              child: Align(
                alignment: Alignment.center,
                child: Text('Buy'),
              ),
            ),
          ),
          Tab(
            child: Container(
              width: SizeConfig.blockSizeHorizontal*20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      SizeConfig.blockSizeHorizontal * 10)),
              child: Align(
                alignment: Alignment.center,
                child: Text('Sell'),
              ),
            ),
          ),
        ],
        indicator: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 10),
        ),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black87,
        unselectedLabelColor: Colors.black26,
      ),
    );
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(top: false, sliver: flexibleSpaceWidget),
            )
          ];
        },
        body: TabBarView(
          children: [BuyCar(), SellCar()],
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 8,
        top: SizeConfig.blockSizeVertical * 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buy / Sell',
                style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 6),
              ),
              Container(
                color: Color(0xFFFF7F98),
                height: SizeConfig.blockSizeHorizontal,
                width: SizeConfig.blockSizeHorizontal * 5,
              ),
            ],
          ),
          Center(
            child: Container(
              height: SizeConfig.blockSizeVertical * 25,
              width: SizeConfig.blockSizeHorizontal * 70,
              child: Hero(
                tag: 'Buy / Sell',
                              child: SvgPicture.asset(
                  "images/car_buy_sell.svg",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
