import 'package:login_and_registration/data/init/init_service.dart';

import 'constants.dart';

///Parse to int or returns [defaultValue]
///
int toInt(
  Object value, {
  int defaultValue = defaultInt,
}) {
  int number = defaultValue;
  try {
    number = toDouble(value).toInt();
  } on Exception catch (e, s) {
    logger.e("toInt", e, s);
  }
  return number;
}

///Parse to double or returns [defaultValue]
///
double toDouble(
  Object value, {
  double defaultValue = defaultDouble,
}) {
  double number = defaultDouble;
  try {
    number = double.parse('$value');
  } on Exception catch (e, s) {
    logger.e("toDouble", e, s);
  }
  return number;
}
