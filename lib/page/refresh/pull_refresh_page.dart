import 'package:flutter/material.dart';

class PullRefreshPage extends StatefulWidget {
  const PullRefreshPage({super.key});

  @override
  State<PullRefreshPage> createState() => _PullRefreshPageState();
}

class _PullRefreshPageState extends State<PullRefreshPage> {
  List<num> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RefreshIndicator(child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Container();
            },
          ), onRefresh: () async {
            data.addAll(await refreshData());
          },)
        ],
      ),
    );
  }

  Future<List<num>> refreshData() async {
    List<num> data = List.generate(10, (index) => (index + 1));
    return data;
  }

  Future loadMoreData() async {
    List<num> data = List.generate(20, (index) => (index + 1));
    return data;
  }
}
