import 'package:focus_timer/models/session.dart';
import 'package:focus_timer/repositories/storage_repository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SessionsModel extends StatesRebuilder {
  final StorageRepository storageRepository;

  SessionsModel(this.storageRepository);

  List<Session> sessions;
  Session currentSession;
  bool isPause;
}
