
import 'package:flutter/material.dart';

import '../model/book.dart';
import '../util/book_router_delegate.dart';

class BookDetailPage extends Page {
  BookDetailPage(this.book);
  Book book;
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (book != null) ...[
                  Text(book.title),
                  Text(book.author),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}