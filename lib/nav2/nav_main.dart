import 'package:flutter/material.dart';
import 'package:nav2/nav2/util/book_router_delegate.dart';
import 'util/book_route_information_parser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final BookRouteInformationParser _bookRouteInformationParser = BookRouteInformationParser();
  final BookRouterDelegate _bookRouterDelegate = BookRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      title: 'nav 2.0',
      routeInformationParser: _bookRouteInformationParser,
      routerDelegate: _bookRouterDelegate,
    );
  }
}


