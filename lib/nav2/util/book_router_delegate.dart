import 'package:nav2/nav2/model/book.dart';
import 'package:nav2/nav2/model/book_route_path.dart';
import 'package:flutter/material.dart';
import 'package:nav2/nav2/view/books_list_screen.dart';


List<Book> books = [
  Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
  Book('Foundation', 'Isaac Asimov'),
  Book('Fahrenheit 451', 'Ray Bradbury'),
];


class BookRouterDelegate extends RouterDelegate<BookRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
  Book? _selectedBook;
  bool show404 = false;
  List  stocks = ['a','b'];

  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      // onGenerateInitialRoutes: (){},
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
        if (_selectedBook != null && show404 == false) MaterialPage(
          key: ValueKey(_selectedBook),
            child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_selectedBook != null) ...[
                      Text(_selectedBook!.title),
                      Text(_selectedBook!.author),
                    ],
                  ],
                ),
              ),
            )
        ),
        if (show404 && _selectedBook == null)
          MaterialPage(
              child: Center(
                  child: Image.asset(
            'assets/img.png',
          )))
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _selectedBook = null;
        notifyListeners();
        return false;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => key;

  @override
  BookRoutePath get currentConfiguration {

    if (show404) {
      return BookRoutePath.showError();
    } else if (_selectedBook == null) {
      return BookRoutePath.home();
    } else {
      return BookRoutePath.detail(books.indexOf(_selectedBook!));
    }
  }

  @override
  Future<void> setNewRoutePath(BookRoutePath configuration) async {

    if (configuration.isError) {
      show404 = true;
      _selectedBook = null;
      notifyListeners();
    }

    if(configuration.id != null){
      if(configuration.id! < 0 || configuration.id! > books.length - 1){
        show404 = true;
        _selectedBook = null;
        notifyListeners();
      }
    }

    if (configuration.isDetailPage) {
      show404 = false;
      _selectedBook = books[configuration.id!];
      notifyListeners();
    }

    if (!configuration.isError && !configuration.isDetailPage) {
      show404 = false;
      _selectedBook = null;
      notifyListeners();
    }

  }
}
