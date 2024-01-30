class CountState {
  CountState init() {
    return CountState();
  }

  CountState clone() {
    return CountState();
  }
}


class CountResultState extends CountState{
  String result = "";

  CountResultState({required this.result});

}