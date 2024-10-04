import 'package:flutter/widgets.dart';
import 'package:login_and_registration/data/init/init_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LoggerScreen extends StatelessWidget {
  const LoggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(
      talker: logger.talker,
    );
  }
}
