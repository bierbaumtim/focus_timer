import 'package:flutter/material.dart';

import 'package:auto_animated/auto_animated.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../state_models/session_model.dart';
import '../soft/soft_button.dart';
import '../soft/soft_container.dart';
import 'session_tile.dart';

class SessionsListContainer extends StatefulWidget {
  const SessionsListContainer({Key key}) : super(key: key);

  @override
  _SessionsListContainerState createState() => _SessionsListContainerState();
}

class _SessionsListContainerState extends State<SessionsListContainer> {
  ScrollController sessionsScrollController;

  @override
  void initState() {
    super.initState();
    sessionsScrollController = ScrollController();
  }

  @override
  void dispose() {
    sessionsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SoftContainer(
        radius: 28,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListTile(
                  title: Text('Sessions'),
                ),
              ),
              Expanded(
                child: ViewModelBuilder<SessionsModel>.reactive(
                  viewModelBuilder: () => context.read<SessionsModel>(),
                  disposeViewModel: false,
                  builder: (context, model, child) {
                    // if (currentSessionModel.allSessionsCompleted) {
                    //   return const Center(
                    //     child: Text(
                    //       'You\'ve done all your tasks',
                    //     ),
                    //   );
                    // } else
                    if (model.sessions.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: AnimateIfVisibleWrapper(
                          showItemInterval: const Duration(milliseconds: 150),
                          controller: sessionsScrollController,
                          child: ReorderableListView(
                            children: model.sessions
                                .map<Widget>(
                                  (session) => AnimateIfVisible(
                                    key: ValueKey(
                                      session.uuid,
                                    ),
                                    builder: (context, animation) =>
                                        FadeTransition(
                                      opacity: Tween<double>(
                                        begin: 0,
                                        end: 1,
                                      ).animate(animation),
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0.5, 0),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: SessionTile(
                                          session: session,
                                          index:
                                              model.sessions.indexOf(session),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onReorder: model.reorderSession,
                            scrollController: sessionsScrollController,
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Add sessions',
                        ),
                      );
                    }
                  },
                ),
              ),
              Center(
                child: SoftButton(
                  radius: 15,
                  onTap: () => context.read<SessionsModel>().addSession(null),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Icon(Icons.add),
                        SizedBox(width: 12),
                        Text('Add Session'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
