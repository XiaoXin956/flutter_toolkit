import 'package:flutter/material.dart';

class CxcHomePage extends StatefulWidget {
  const CxcHomePage({super.key});

  @override
  State<CxcHomePage> createState() => _CxcHomePageState();
}

class _CxcHomePageState extends State<CxcHomePage> {
  List<MenuBean> topMenu = [];
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text("多级菜单"),
      ),
      body: Row(
        children: [
          /// 左侧
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      addMenuData("物流信息", addWuLiuData());
                    },
                    child: SizedBox(height: 50, child: Text("物流信息")),
                  ),
                  GestureDetector(
                    onTap: () {
                      addMenuData("客户信息", addKeFuData());
                    },
                    child: SizedBox(height: 50, child: Text("客户信息")),
                  ),
                  GestureDetector(
                    onTap: () {
                      addMenuData("票据信息", addPiaoJuData());
                    },
                    child: SizedBox(height: 50, child: Text("票据信息")),
                  ),
                ],
              )),

          /// 右侧
          Expanded(
              flex: 5,
              child: (topMenu.isNotEmpty)
                  ? Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: topMenu
                                .asMap()
                                .entries
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        addMenuData(e.value.title, null);
                                      },
                                      child: Container(
                                        color: Colors.blue,
                                        child: Row(
                                          children: [
                                            Text(e.value.title),
                                            GestureDetector(
                                              onTap: () {
                                                removeData(e.key);
                                              },
                                              child: Icon(Icons.close_rounded),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: PageView(
                            controller: _pageController,
                            children: topMenu
                                .map((e) => Container(
                                      height: 200,
                                      child: e.child,
                                    ))
                                .toList(),
                          ),
                        )
                      ],
                    )
                  : Container()),
        ],
      ),
    );
  }

  addMenuData(String dataMenu, Widget? child) {
    for (var i = 0; i < topMenu.length; i++) {
      if (dataMenu == topMenu[i].title) {
        _pageController.jumpToPage(i);
        return;
      }
    }
    topMenu.add(MenuBean(title: dataMenu, child: child!));
    setState(() {});
    _pageController.jumpToPage(topMenu.length);
  }

  removeData(int dataMenuIndex) {
    topMenu.removeAt(dataMenuIndex);
    setState(() {});
  }

  // 添加物流信息
  addWuLiuData() {
    return Container(
      color: Colors.red,
      width: 100,
      height: 100,
      child: Text("物流信息"),
    );
  }

  // 添加票据信息
  addPiaoJuData() {
    return Container(
      color: Colors.yellow,
      width: 100,
      height: 100,
      child: Text("票据信息"),
    );
  }

  // 添加客服信息
  addKeFuData() {
    return Container(
      color: Colors.blue,
      width: 100,
      height: 100,
      child: Text("客服信息"),
    );
  }
}

class MenuBean {
  String title;
  Widget child;

  MenuBean({required this.title, required this.child});
}
