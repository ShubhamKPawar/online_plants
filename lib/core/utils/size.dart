import 'package:online_plants_app/core/utils/size_config.dart';

double getHeight(double height) {
  final double defaultLandscapeHeight = 392;
  final double defaultPortraitHeight = 803;
  if (!SizeConfig.isLandscape) {
    double deviceHeight = SizeConfig.devideHeigth <= defaultPortraitHeight
        ? defaultPortraitHeight
        : SizeConfig.devideHeigth;
    double result = height / deviceHeight;
    return SizeConfig.devideHeigth * result;
  } else {
    double deviceHeight = SizeConfig.devideHeigth <= defaultLandscapeHeight
        ? defaultLandscapeHeight
        : SizeConfig.devideHeigth;
    double result = height / deviceHeight;
    return SizeConfig.devideHeigth * result;
  }
}

double getWidth(double width) {
  final double defaultLandscapeWidth = 774;
  final double defaultPortraitWidth = 392;
  if (!SizeConfig.isLandscape) {
    double deviceWidth = SizeConfig.deviceWidth <= defaultPortraitWidth
        ? defaultPortraitWidth
        : SizeConfig.deviceWidth;
    double result = width / deviceWidth;
    return SizeConfig.deviceWidth * result;
  } else {
    double deviceWidth = SizeConfig.deviceWidth <= defaultLandscapeWidth
        ? defaultLandscapeWidth
        : SizeConfig.deviceWidth;
    double result = width / deviceWidth;
    return SizeConfig.deviceWidth * result;
  }
}
