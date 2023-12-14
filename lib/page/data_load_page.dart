import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toolkit/blocs/data_loading/data_load_bloc.dart';
import 'package:flutter_toolkit/blocs/data_loading/data_load_event.dart';
import 'package:flutter_toolkit/blocs/data_loading/data_load_state.dart';
import 'package:flutter_toolkit/widgets/snack_bar_utils.dart';

class DataLoadPage extends StatelessWidget {
  List<dynamic> data = [];
  EasyRefreshController? _easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  DataLoadPage({super.key});

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => DataLoadBloc(),
      child: BlocBuilder<DataLoadBloc,DataLoadState>(
        builder: (BuildContext context, state) {

          DataLoadBloc dataLoadBloc = context.read<DataLoadBloc>();

          if (state is DataLoadInitialState) {
          } else if (state is DataLoadLoadingState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              // 进行加载
              _easyRefreshController?.callRefresh();
            });
          } else if (state is DataLoadSuccessState) {
            // 进行加载
            data.addAll(state.dataSuccess);
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              _easyRefreshController?.finishRefresh();
              _easyRefreshController?.finishLoad();
            });
          } else if (state is DataLoadFailState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              // 进行加载
              showSnackBar(msg: "加载异常");
              _easyRefreshController?.finishRefresh();
              _easyRefreshController?.finishLoad();
            });          }

          return Scaffold(
            body: Container(
              child: EasyRefresh(
                header: MaterialHeader(),
                footer: MaterialFooter(),
                controller: _easyRefreshController,
                onRefresh: (){
                  dataLoadBloc.add(DataLoadLoadEvent(data: {"type":0}));
                },
                onLoad: (){
                  dataLoadBloc.add(DataLoadLoadEvent(data: {"type":1}));
                  },
                child: ListView.builder(
                  itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Text("${data[index].toString()}"),
                  );
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
