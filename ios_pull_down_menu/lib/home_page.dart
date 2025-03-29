import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pull Down Buttons Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton.filled(
              child: const Text("Medium size action item"),
              onPressed: () async {
                await showPullDownMenu(
                  context: context,
                  position: Rect.fromCenter(
                    center: Offset(
                      MediaQuery.sizeOf(context).width / 2,
                      MediaQuery.sizeOf(context).height / 2,
                    ),
                    width: 0,
                    height: 0,
                  ),
                  items: [
                    PullDownMenuHeader(
                      onTap: () {},
                      leading: SizedBox.shrink(),
                      title: 'Filter',
                      // icon: CupertinoIcons.profile_circled,
                    ),
                    PullDownMenuItem(
                      onTap: () {},
                      title: "Pin",
                      icon: CupertinoIcons.pin,
                    ),
                    PullDownMenuItem(
                      onTap: () {},
                      title: "Forward",
                      subtitle: "Share in different channel",
                      icon: CupertinoIcons.arrowshape_turn_up_right,
                    ),
                    PullDownMenuItem(
                      onTap: () {},
                      title: "Delete",
                      isDestructive: true,
                      itemTheme: PullDownMenuItemTheme(),
                      icon: CupertinoIcons.delete,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            CupertinoButton.filled(
              child: const Text("Medium size action row"),
              onPressed: () async {
                await showPullDownMenu(
                  context: context,
                  items: [
                    PullDownMenuTitle(
                      title: Text("Pin", style: TextStyle(fontSize: 20)),
                    ),
                    PullDownMenuItem.selectable(onTap: () {}, title: "Select"),
                    PullDownMenuActionsRow.small(
                      items: [
                        PullDownMenuItem(
                          onTap: () {},
                          title: "Copy",
                          icon: CupertinoIcons.doc_on_doc,
                        ),
                        PullDownMenuItem(
                          onTap: () {},
                          title: "Edit",
                          icon: CupertinoIcons.pencil,
                        ),
                        PullDownMenuItem(
                          onTap: () {},
                          title: "Edit",
                          icon: CupertinoIcons.pencil,
                        ),
                      ],
                    ),
                  ],
                  position: Rect.fromCenter(
                    center: Offset(
                      MediaQuery.sizeOf(context).width / 2,
                      MediaQuery.sizeOf(context).height / 2,
                    ),
                    width: 0,
                    height: 0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
