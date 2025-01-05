// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';

double WIDTH = 0.0;
double HEIGHT = 0.0;
bool ISLANDSCAPE = false;
HivePreference? hiveInstance;
UserCredential? USER_CREDENTIAL;

bool isDark = false;
