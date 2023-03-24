import 'package:flutter/material.dart';

import '/utils/color_utils.dart';

class TabChild {
  String title;
  Color cor;
  Widget child;

  TabChild(this.title, this.cor, this.child);
}

class TabView extends StatefulWidget {
  final List<TabChild> childs;

  const TabView(this.childs);

  @override
  _TabViewState createState() => _TabViewState(childs);
}

class _TabViewState extends State<TabView> with TickerProviderStateMixin {
  int index = 0;
  TabController? tabController;

  List<TabChild> childs;

  _TabViewState(this.childs);
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: childs.length, vsync: this);
    tabController!.addListener(() {
      setState(() {
        index = tabController!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: childs.map((e) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        index = childs.indexOf(e);
                      });
                      tabController!.animateTo(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: index == childs.indexOf(e)
                            ? colorPrimary.withOpacity(0.2)
                            : colorGrayLight2,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                          child: Text(
                        e.title,
                        style: TextStyle(
                            color: index == childs.indexOf(e)
                                ? e.cor
                                : colorGrayDark2,
                            fontWeight: index == childs.indexOf(e)
                                ? FontWeight.w600
                                : FontWeight.w400),
                      )),
                    ),
                  ),
                );
              }).toList()),
          const SizedBox(
            height: 0,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: childs.map((e) => e.child).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
