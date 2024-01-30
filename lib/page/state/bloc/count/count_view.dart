import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'count_cubit.dart';
import 'count_state.dart';

class CountPage extends StatelessWidget {

  CountCubit? countCubit;

  String result = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountCubit>(
      create: (BuildContext context) => CountCubit(),
      child: BlocBuilder<CountCubit,CountState>(builder: (context,state){
        countCubit = BlocProvider.of<CountCubit>(context);
        if(state is CountResultState){
          result = state.result;
        }
        return _buildPage(context);
      }),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("${result}"),
          TextButton(onPressed: (){
            countCubit?.getResult();
          }, child: Text("+++++")),
          TextButton(onPressed: (){
            countCubit?.getResult();}, child: Text("-----")),
        ],
      ),
    );
  }
}


