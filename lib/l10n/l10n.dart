import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';

extension StringsX on BuildContext {
  Strings get l10n => Strings.of(this)!;
}
