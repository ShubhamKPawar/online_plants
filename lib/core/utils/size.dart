import 'package:online_plants_app/core/constants/constant.dart';

double getHeight(double height) {
  if (!ISLANDSCAPE) {
    double result = height / 803;
    return HEIGHT * result;
  } else {
    double result = height / 392;
    return HEIGHT * result;
  }
}

double getWidth(double width) {
  if (!ISLANDSCAPE) {
    double result = width / 392;
    return WIDTH * result;
  } else {
    double result = width / 774;
    return WIDTH * result;
  }
}
