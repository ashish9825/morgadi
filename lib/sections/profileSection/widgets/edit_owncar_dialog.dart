import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:morgadi/sections/profileSection/widgets/own_car_widget.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';
import 'package:morgadi/sections/profileSection/bloc/edit_profile.dart';

class EditOwnCarDialog extends StatelessWidget {
  final EditProfileBloc editProfileBloc;
  final bool ownCar;

  EditOwnCarDialog({this.editProfileBloc, this.ownCar});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => editProfileBloc,
      child: EditOwnCarConfirm(
        editProfileBloc: editProfileBloc,
        ownCar: ownCar,
      ),
    );
  }
}

class EditOwnCarConfirm extends StatelessWidget {
  final EditProfileBloc editProfileBloc;
  final bool ownCar;

  EditOwnCarConfirm({this.editProfileBloc, this.ownCar});

  bool ownCarController;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: BlocListener<EditProfileBloc, EditProfileState>(
        cubit: editProfileBloc,
        listener: (context, editOwnCarState) {
          if (editOwnCarState is EditExceptionState) {
            String message;
            message = editOwnCarState.message;

            print('Error: $message');
          }
        },
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          cubit: editProfileBloc,
          builder: (context, state) => getViewAsPerState(state, context),
        ),
      ),
    );
  }

  getViewAsPerState(EditProfileState state, BuildContext context) {
    print('STATE: $state');
    if (state is InitialEditState) {
      return _dialogContent(context);
    } else if (state is EditLoadingState) {
      return _loadingIndicator();
    } else if (state is EditOwnCarCompletedState) {
      return _confirmedContent(context);
    } else if (state is EditNoInternetState) {
      return _noInternetContent(context);
    } else {
      return _dialogContent(context);
    }
  }

  Widget _dialogContent(BuildContext context) {
    initializeOwnCar();

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
          Text(
            'Do you own a car ?',
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
          ),
          Container(
            color: Color(0xFFFF7F98),
            height: SizeConfig.blockSizeHorizontal,
            width: SizeConfig.blockSizeHorizontal * 5,
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 4),
          StatefulBuilder(
            builder: (buildContext, stateSetter) => Container(
              height: SizeConfig.blockSizeVertical * 4.5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: yesOrNo.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      stateSetter(() {
                        yesOrNoOptions
                            .forEach((element) => element.isSelected = false);
                        yesOrNoOptions[index].isSelected = true;
                      });
                      ownCarController = yesOrNoOptions[0].isSelected == true
                          ? ownCarController = true
                          : ownCarController = false;
                    },
                    child: OwnCarWidget(yesOrNoOptions[index]),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 4,
                ),
                InkWell(
                  onTap: () {
                  editProfileBloc.add(
                      EditOwnCarEvent(ownCarController),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 2,
                        vertical: SizeConfig.blockSizeVertical * 1),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeHorizontal * 2),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
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

  Widget _loadingIndicator() {
    return Container(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 1.5,
        bottom: SizeConfig.blockSizeVertical * 1.5,
        left: SizeConfig.blockSizeHorizontal * 4,
        right: SizeConfig.blockSizeHorizontal * 4,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitRipple(
              color: Colors.yellow,
              size: SizeConfig.blockSizeHorizontal * 20,
              borderWidth: SizeConfig.blockSizeHorizontal * 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _confirmedContent(BuildContext context) {
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 30,
            width: SizeConfig.blockSizeHorizontal * 50,
            child: Lottie.asset("assets/confirm_tick.json"),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 8,
                    vertical: SizeConfig.blockSizeVertical * 1),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noInternetContent(BuildContext context) {
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 40,
            width: SizeConfig.blockSizeHorizontal * 60,
            child: Lottie.asset("assets/no_internet.json"),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 3,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 8,
                    vertical: SizeConfig.blockSizeVertical * 1),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.blockSizeHorizontal * 2),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initializeOwnCar() {
    ownCarController = ownCar;
    if (ownCar == true) {
      yesOrNoOptions[1].isSelected = false;
      yesOrNoOptions[0].isSelected = true;
    } else {
      yesOrNoOptions[1].isSelected = true;
      yesOrNoOptions[0].isSelected = false;
    }
  }
}
