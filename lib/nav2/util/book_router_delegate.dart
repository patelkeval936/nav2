import 'package:nav2/nav2/model/book.dart';
import 'package:nav2/nav2/model/book_route_path.dart';
import 'package:flutter/material.dart';
import 'package:nav2/nav2/view/book_detail_screen.dart';
import 'package:nav2/nav2/view/books_list_screen.dart';

class BookRouterDelegate extends RouterDelegate<BookRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  Book? _selectedBook;
  bool show404 = false;

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ];

  @override
  Widget build(BuildContext context) {
    print('Route Delegate : build');
    print('     selected book : ${_selectedBook?.title}');
    return Navigator(
      key: key,
      pages: [
        MaterialPage(
          child: BooksListScreen(
            books: books,
            onTapped: (Book value) {
              _selectedBook = value;
              notifyListeners();
            },
          ),
        ),
        if(_selectedBook != null) BookDetailPage(_selectedBook!),
        // if (_selectedBook != null) MaterialPage(
        //     child: Scaffold(
        //       appBar: AppBar(),
        //       body: Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             if (_selectedBook != null) ...[
        //               Text(_selectedBook!.title),
        //               Text(_selectedBook!.author),
        //             ],
        //           ],
        //         ),
        //       ),
        //     )
        // ),
        if (show404 && _selectedBook == null)
          MaterialPage(
              child: Center(
                  child: Image.asset(
            'assets/img.png',
          )))
      ],
      onPopPage: (route, result) {
        print('Route Delegate : on pop page');
        if (!route.didPop(result)) {
          return false;
        }
        _selectedBook = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => key;

  @override
  BookRoutePath get currentConfiguration {
    print('Route Delegate : get current configuration');

    if (show404) {
      return BookRoutePath.showError();
    } else if (_selectedBook == null) {
      print('     selected book = null');
      return BookRoutePath.home();
    } else {
      print('     selected book = ${_selectedBook?.title} and index is ${books.indexOf(_selectedBook!)}');
      return BookRoutePath.detail(books.indexOf(_selectedBook!));
    }
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath configuration) async {
    print('Route Delegate : set new route path');
    print('     config is Homepage : ${configuration.isHomePage}, DetailPage : ${configuration.isDetailPage}, id : ${configuration.id}');

    if (!configuration.isError && !configuration.isDetailPage) {
      show404 = false;
      _selectedBook = null;
    }

    if (configuration.isError) {
      show404 = true;
    }

    if (configuration.isDetailPage) {
      _selectedBook = books[configuration.id!];
      notifyListeners();
      print('*******${_selectedBook?.title}********');
    }
  }
}
