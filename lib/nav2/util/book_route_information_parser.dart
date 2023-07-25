
import 'package:flutter/material.dart';

import '../model/book_route_path.dart';

class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {

  @override
  Future<BookRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    Uri uri = Uri.parse(routeInformation.location ?? '');
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

    if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    }

    if(configuration.isError){
      return const RouteInformation(location: '/show404');
    }

    if (configuration.isDetailPage) {
      return RouteInformation(location: '/book/${configuration.id}');
    }

    return null;
  }
}