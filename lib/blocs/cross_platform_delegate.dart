import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'cross_platform_storage.dart';

class CrossPlatformDelegate extends HydratedBlocDelegate {
  /// Instance of `CrossPlatformStorage` used to manage persisted states.
  @override
  final CrossPlatformStorage storage;

  /// Builds a new instance of `CrossPlatformDelegate` with the
  /// default `CrossPlatformStorage`.
  /// A custom `storageDirectory` can optionally be provided.
  ///
  /// This is the recommended way to use a `CrossPlatformDelegate`.
  /// If you want to customize `CrossPlatformDelegate` you can extend `CrossPlatformDelegate`
  /// and perform the necessary overrides.
  static Future<CrossPlatformDelegate> build({
    Directory storageDirectory,
  }) async {
    return CrossPlatformDelegate(
      await CrossPlatformStorage.getInstance(
        storageDirectory: storageDirectory,
      ),
    );
  }

  CrossPlatformDelegate(this.storage) : super(storage);

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    final state = transition.nextState;
    if (bloc is HydratedBloc) {
      final stateJson = bloc.toJson(state);
      if (stateJson != null) {
        storage.write(
          '${bloc.runtimeType.toString()}${bloc.id}',
          json.encode(stateJson),
        );
      }
    }
  }
}
