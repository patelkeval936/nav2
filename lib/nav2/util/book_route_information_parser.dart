
import 'package:flutter/material.dart';

import '../model/book_route_path.dart';

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {

  @override
  Future<BookRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    print('Route Parser : parse route information');
    Uri uri = Uri.parse(routeInformation.location ?? '');
    print('     uri : $uri');
    print(uri.pathSegments);
    if(uri.pathSegments.first == 'show404') {
      return BookRoutePath.showError();
    } else if (uri.pathSegments.length >= 2) {
      int id = int.parse(uri.pathSegments[1]);
      return BookRoutePath.detail(id);
    }   else {
      return BookRoutePath.home();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(BookRoutePath configuration) {
    print('Route Parser : restore route information');

    if (configuration.isHomePage) {
      print('     config is HOME');
      return const RouteInformation(location: '/');
    }

    if(configuration.isError){
      return const RouteInformation(location: '/show404');
    }

    if (configuration.isDetailPage) {
      print('     config is DETAIL PAGE ${configuration.id}');
      return RouteInformation(location: '/book/${configuration.id}');
    }

    return null;
  }
}