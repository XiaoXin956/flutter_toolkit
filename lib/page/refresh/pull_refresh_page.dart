import 'package:flutter/material.dart';
import 'package:flutter_toolkit/utils/print_utils.dart';

class PullRefreshPage extends StatefulWidget {
  const PullRefreshPage({super.key});

  @override
  State<PullRefreshPage> createState() => _PullRefreshPageState();
}

class _PullRefreshPageState extends State<PullRefreshPage> {
  List<num> data = [
    1,
  ];
  ScrollController _scrollController = ScrollController();
  bool isLoadMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("下拉刷新"),
      ),
      body: NotificationListener(
        onNotification: (scrollNotification) {
          // 如果在加载中 或者 数据为空的时候 就不执行
          if (data.isEmpty) {
            return true;
          }

          if (scrollNotification is ScrollEndNotification && scrollNotification.metrics.extentAfter < 300 && !isLoadMore) {
            loadMoreData();
          }

          if (scrollNotification is ScrollUpdateNotification) {
            // 滚动中
            // printBlue("像素  ${_scrollController.position.pixels}        最大滚动范围  ${_scrollController.position.maxScrollExtent}");
            // if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
            //   loadMoreData();
            // }
            print("ScrollUpdateNotification");
          } else if (scrollNotification is ScrollEndNotification) {
            //
            print("ScrollEndNotification");
          } else if (scrollNotification is UserScrollNotification) {
            //
            print("UserScrollNotification");
          } else if (scrollNotification is OverscrollNotification) {
            //
            print("OverscrollNotification");
          } else if (scrollNotification is ScrollStartNotification) {
            //
            print("ScrollStartNotification");
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: () => refreshData(),
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: data.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == data.length) {
                if (isLoadMore) {
                  return Container(
                    height: 50,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 3, bottom: 3),
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              }

              return Container(
                height: 50,
                color: Colors.blueAccent,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 3, bottom: 3),
                child: Text("data[$index]"),
              );
            },
          ),
        ),
      ),
    );
  }

  refreshData() async {
    await Future.delayed(Duration(seconds: 1));
    List<num> dataTemp = List.generate(1, (index) => (index + 1));
    setState(() {
      data.clear();
      data.addAll(dataTemp);
    });
  }

  loadMoreData() async {
    if (isLoadMore) {
      return;
    }
    setState(() {
      isLoadMore = true;
    });
    await Future.delayed(Duration(seconds: 1));
    List<num> dataTemp = List.generate(1, (index) => (index + 1));
    setState(() {
      data.addAll(dataTemp);
      isLoadMore = false;
    });
  }
}
