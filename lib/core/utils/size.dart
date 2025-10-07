import 'package:online_plants_app/core/utils/size_config.dart';

double getHeight(double height) {
  if (!SizeConfig.isLandscape) {
    double result = height / 803;
    return SizeConfig.devideHeigth * result;
  } else {
    double result = height / 392;
    return SizeConfig.devideHeigth * result;
  }
}

double getWidth(double width) {
  if (!SizeConfig.isLandscape) {
    double result = width / 392;
    return SizeConfig.deviceWidth * result;
  } else {
    double result = width / 774;
    return SizeConfig.deviceWidth * result;
  }
}
