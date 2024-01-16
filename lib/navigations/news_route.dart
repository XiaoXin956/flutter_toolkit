import 'package:flutter/cupertino.dart';
import 'package:flutter_toolkit/page/language_page.dart';

class NewsRoute{

  static const LANGUAGE_PAGE = "page/language_page";

  Map<String,WidgetBuilder> routes = {
    LANGUAGE_PAGE :(context)=>LanguagePage(),
  };


}