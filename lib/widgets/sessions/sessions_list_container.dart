import 'package:flutter/material.dart';

import 'package:focus_timer/state_models/session_model.dart';
import 'package:focus_timer/widgets/sessions/session_tile.dart';
import 'package:focus_timer/widgets/soft/soft_button.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';
// import 'package:reorderables/reorderables.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SessionsListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionsModel = Injector.get<SessionsModel>();

    return SoftContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Stack(
          children: <Widget>[
            StateBuilder(
              models: [sessionsModel],
              builder: (context, _) {
                if (sessionsModel.allSessionsCompleted) {
                  return Center(
                    child: Text(
                      'You\'ve done all your tasks',
                    ),
                  );
                } else if (sessionsModel.sessions.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: kToolbarHeight,
                      bottom: kToolbarHeight + 8,
                    ),
                    child: CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            bottom: 14,
                            top: 14,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => SessionTile(
                                session:
                                    sessionsModel.sessions.elementAt(index),
                              ),
                              childCount: sessionsModel.sessions.length,
                            ),
                            // onReorder: (oldIndex, newIndex) => sessionsModel
                            //     .reorderSession(oldIndex, newIndex),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      'Add sessions',
                    ),
                  );
                }
              },
            ),
            Positioned(
              left: 12,
              right: 12,
              child: ListTile(
                title: Text('Sessions'),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 12,
              right: 12,
              child: Center(
                child: SoftButton(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.add),
                        SizedBox(width: 12),
                        Text('Add Session'),
                      ],
                    ),
                  ),
                  radius: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
