import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:morgadi/sections/profileSection/bloc/edit_profile_bloc.dart';
import 'package:morgadi/sections/profileSection/data/profile_repository.dart';
import 'package:morgadi/sections/profileSection/order_dialogs/order_dialogs.dart';
import 'package:morgadi/sections/profileSection/order_dialogs/spares_order_dialog.dart';
import 'package:morgadi/sections/profileSection/widgets/order_items.dart';
import 'package:morgadi/utils/size_config.dart';

class MorgadiOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EditProfileBloc(profileRepository: ProfileRepository()),
      child: OrdersScreen(),
    );
  }
}

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  ProfileRepository _profileRepository = ProfileRepository();
  EditProfileBloc _editProfileBloc;

  @override
  void initState() {
    _editProfileBloc = BlocProvider.of<EditProfileBloc>(context);
    super.initState();
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
      body: _ordersBody(),
    );
  }

  Widget _ordersBody() {
    return ListView(
      children: [
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
                'My Orders',
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
              _ordersList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ordersList() {
    return StreamBuilder(
      stream: _editProfileBloc.internetStream,
      builder: (ctxt, AsyncSnapshot<DataConnectionStatus> snap) {
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rentOrders(),
                  buyOrders(),
                  sellOrders(),
                  repairOrders(),
                  mortgageOrders(),
                  sparePartsOrders(),
                ],
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
      },
    );
  }

  Widget rentOrders() {
    return StreamBuilder<QuerySnapshot>(
      stream: _profileRepository.fetchRentOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.length > 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rent A Car',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical,
                ),
                Column(
                  children: List.generate(
                    snapshot.data.docs.length,
                    (index) => InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                RentOrderDialog(snapshot.data.docs[index]),
                          );
                        },
                        child: RentOrderItem(snapshot.data.docs[index])),
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        } else if (snapshot.hasError) {
          return _errorWidget(snapshot.error);
        } else {
          return _loadingIndicator();
        }
      },
    );
  }

  Widget buyOrders() {
    return StreamBuilder<QuerySnapshot>(
      stream: _profileRepository.fetchBuyOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.length > 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Text(
                  'Buy',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical,
                ),
                Column(
                  children: List.generate(
                    snapshot.data.docs.length,
                    (index) => InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              BuyOrderDialog(snapshot.data.docs[index]),
                        );
                      },
                      child: BuyOrderItem(
                        snapshot.data.docs[index],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        } else if (snapshot.hasError) {
          return _errorWidget(snapshot.error);
        } else {
          return _loadingIndicator();
        }
      },
    );
  }

  Widget sellOrders() {
    return StreamBuilder<QuerySnapshot>(
      stream: _profileRepository.fetchSellOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.length > 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Text(
                  'Sell',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical,
                ),
                Column(
                  children: List.generate(
                    snapshot.data.docs.length,
                    (index) => InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                SellOrderDialog(snapshot.data.docs[index]),
                          );
                        },
                        child: SellOrderItem(snapshot.data.docs[index])),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        } else if (snapshot.hasError) {
          return _errorWidget(snapshot.error);
        } else {
          return _loadingIndicator();
        }
      },
    );
  }

  Widget repairOrders() {
    return StreamBuilder(
      stream: _profileRepository.fetchRepairOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.length > 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Text(
                  'Repairing',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical,
                ),
                Column(
                  children: List.generate(
                    snapshot.data.docs.length,
                    (index) => InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              RepairOrderDialog(snapshot.data.docs[index]),
                        );
                      },
                      child: RepairOrderItem(snapshot.data.docs[index]),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        } else if (snapshot.hasError) {
          return _errorWidget(snapshot.error);
        } else {
          return _loadingIndicator();
        }
      },
    );
  }

  Widget mortgageOrders() {
    return StreamBuilder(
      stream: _profileRepository.fetchMortgageOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.length > 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Text(
                  'Mortgage Service',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical,
                ),
                Column(
                  children: List.generate(
                    snapshot.data.docs.length,
                    (index) => InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                MortgageOrderDialog(snapshot.data.docs[index]),
                          );
                        },
                        child: MortgageOrderItem(snapshot.data.docs[index])),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        } else if (snapshot.hasError) {
          return _errorWidget(snapshot.error);
        } else {
          return _loadingIndicator();
        }
      },
    );
  }

  Widget sparePartsOrders() {
    return StreamBuilder(
      stream: _profileRepository.fetchSparePartOrders(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.length > 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
                Text(
                  'Spares & Accessories',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical,
                ),
                Column(
                  children: List.generate(
                    snapshot.data.docs.length,
                    (index) => InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                SparesOrderDialog(snapshot.data.docs[index]),
                          );
                        },
                        child: SparesOrderItem(snapshot.data.docs[index])),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 3,
                ),
              ],
            );
          } else {
            return Container();
          }
        } else if (snapshot.hasError) {
          return _errorWidget(snapshot.error);
        } else {
          return _loadingIndicator();
        }
      },
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

  Widget _itemText(QueryDocumentSnapshot doc) {
    return Text(doc.get('userId'));
  }
}
