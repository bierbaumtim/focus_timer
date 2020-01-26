import '../models/session.dart';
import '../state_models/current_session_model.dart';
import '../state_models/session_model.dart';

class SessionService {
  final SessionsModel sessionsModel;
  final CurrentSessionModel currentSessionModel;

  const SessionService(this.sessionsModel, this.currentSessionModel);

  void updateSession(Session session) {
    sessionsModel.updateSession(session);
    currentSessionModel.updateCurrentSession(session);
  }

  void startBreak() {
    final session = currentSessionModel.currentSession.copyWith(
      isCompleted: true,
    );
    currentSessionModel.startBreak();
    sessionsModel.updateSession(session);
  }
}
