import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';

import 'package:focus_timer/state_models/session_model.dart';
import 'package:focus_timer/widgets/sessions/session_tile.dart';
import 'package:focus_timer/widgets/soft/soft_button.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';
// import 'package:reorderables/reorderables.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SessionsListContainer extends StatefulWidget {
  @override
  _SessionsListContainerState createState() => _SessionsListContainerState();
}

class _SessionsListContainerState extends State<SessionsListContainer> {
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
                  return const Center(
                    child: Text(
                      'You\'ve done all your tasks',
                    ),
                  );
                } else if (sessionsModel.sessions.isNotEmpty) {
                  // return Padding(
                  //   padding: const EdgeInsets.only(
                  //     top: kToolbarHeight,
                  //     bottom: kToolbarHeight + 8,
                  //   ),
                  //   child: CustomScrollView(
                  //     controller: controller,
                  //     physics: BouncingScrollPhysics(),
                  //     slivers: <Widget>[
                  //       SliverPadding(
                  //         padding: const EdgeInsets.only(
                  //           bottom: 14,
                  //           top: 14,
                  //         ),
                  //         sliver: LiveSliverList(
                  //           itemCount: sessionsModel.sessions.length,
                  //           controller: controller,
                  //           itemBuilder: (context, index, animation) =>
                  //               FadeTransition(
                  //             opacity: Tween<double>(
                  //               begin: 0,
                  //               end: 1,
                  //             ).animate(animation),
                  //             child: SlideTransition(
                  //               position: Tween<Offset>(
                  //                       begin: Offset(1, -0.1),
                  //                       end: Offset.zero)
                  //                   .animate(animation),
                  //               child: SessionTile(
                  //                 session:
                  //                     sessionsModel.sessions.elementAt(index),
                  //                 index: index + 1,
                  //               ),
                  //             ),
                  //           ),
                  //           showItemDuration: Duration(milliseconds: 175),
                  //           // delegate: SliverChildBuilderDelegate(
                  //           //   (context, index) => SessionTile(
                  //           //     session:
                  //           //         sessionsModel.sessions.elementAt(index),
                  //           //     index: index + 1,
                  //           //   ),
                  //           //   childCount: sessionsModel.sessions.length,
                  //           // ),
                  //           // onReorder: (oldIndex, newIndex) => sessionsModel
                  //           //     .reorderSession(oldIndex, newIndex),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: kToolbarHeight,
                      bottom: kToolbarHeight + 8,
                    ),
                    child: AnimateIfVisibleWrapper(
                      showItemInterval: const Duration(milliseconds: 150),
                      child: ListView.builder(
                        controller: controller,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => AnimateIfVisible(
                          key: ValueKey(
                            sessionsModel.sessions.elementAt(index).uid,
                          ),
                          builder: (context, animation) => FadeTransition(
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
                                session:
                                    sessionsModel.sessions.elementAt(index),
                                index: index + 1,
                              ),
                            ),
                          ),
                        ),
                        itemCount: sessionsModel.sessions.length,
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
            const Positioned(
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
                  radius: 15,
                  onTap: () => sessionsModel.addSession(null),
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
            ),
          ],
        ),
      ),
    );
  }
}
