import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerBlocObserver extends BlocObserver {
  final Talker talker;

  TalkerBlocObserver({required this.talker});

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    talker.info('Bloc created: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    talker.info('Event added: ${bloc.runtimeType}, Event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    talker.info('Transition: ${bloc.runtimeType}, Transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    talker.error(
      'Error in ${bloc.runtimeType}',
      error,
      stackTrace,
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    talker.info('State change: ${bloc.runtimeType}, Change: $change');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    talker.info('Bloc closed: ${bloc.runtimeType}');
  }
}
