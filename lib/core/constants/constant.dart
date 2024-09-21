import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';

double WIDTH = 0.0;
double HEIGHT = 0.0;
HivePreference? hiveInstance;
UserCredential? USER_CREDENTIAL;

const String fontFamilyCustom = "poppins";
bool isDark = false;
