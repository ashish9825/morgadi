import 'package:flutter/material.dart';
import 'package:morgadi/utils/constants.dart';
import 'package:morgadi/utils/size_config.dart';

class CarBrandDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 1.5,
          bottom: SizeConfig.blockSizeVertical * 1.5,
          left: SizeConfig.blockSizeHorizontal * 4,
          right: SizeConfig.blockSizeHorizontal * 4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Car Brand',
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            ),
            Container(
              color: Color(0xFFFF7F98),
              height: SizeConfig.blockSizeHorizontal,
              width: SizeConfig.blockSizeHorizontal * 5,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            _modelsBody(context),
          ],
        ),
      ),
    );
  }

  Widget _modelsBody(BuildContext context) {
    return Column(
      children: List.generate(
        carBrands.length,
        (index) => modelWidget(carBrands[index], context),
      ),
    );
  }

  modelWidget(String model, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, model);
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(model),
            ],
          ),
        ),
      ),
    );
  }
}
