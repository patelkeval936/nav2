import 'dart:developer';

import 'package:flutter/material.dart';

import 'middleware.dart';

void main() => runApp(MyApp());

RouteObserver routeObserver = RouteObserver<ModalRoute>();

NavigatorMiddleware<PageRoute> middleware = NavigatorMiddleware<PageRoute>(
  onPush: (abc, previousRoute) {
    log('we have push event');
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator middleware',
      theme: ThemeData.dark(),
      routes: {'/': (context) => HomePage(),
        '/page1': (context) => Page1(),
        '/page2': (context) => Page2(),
        '/page3': (context) => Page3()
      },
      navigatorObservers: [middleware],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {

  // @override
  // void didPop() {
  //   String? routeName = ModalRoute.of(context)?.settings.name;
  //   print('did pop $routeName');
  //   super.didPop();
  // }
  //
  // @override
  // void didPush() {
  //   String? routeName = ModalRoute.of(context)?.settings.name;
  //   print('did push $routeName');
  //   super.didPush();
  // }
  //
  // @override
  // void didPopNext() {
  //   String? routeName = ModalRoute.of(context)?.settings.name;
  //   print('did pop next $routeName');
  //   super.didPopNext();
  // }
  //
  // @override
  // void didPushNext() {
  //   String? routeName = ModalRoute.of(context)?.settings.name;
  //   print('did push next $routeName');
  //   super.didPushNext();
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   routeObserver.subscribe(this, ModalRoute.of(context)!);
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: ElevatedButton(onPressed: (){
      Navigator.of(context).pushNamed('/page1');
    }, child: Text('go to page 1')),));
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with RouteAware {

  // @override
  // void didPop() {
  //   String? routeName = ModalRoute.of(context)?.settings.name;
  //   print('did pop $routeName');
  //   super.didPop();
  // }
  //
  // @override
  // void didPush() {
  //   String? routeName = ModalRoute.of(context)?.settings.name;
  //   print('did push $routeName');
  //   super.didPush();
  // }
  //
  // @override
  // void didPopNext() {
  //   String? routeName = ModalRoute.of(context)?.settings.name;
  //   print('did pop next $routeName');
  //   super.didPopNext();
  // }
  //
  // @override
  // void didPushNext() {
  //   String? routeName = ModalRoute.of(context)?.settings.name;
  //   print('did push next $routeName');
  //   super.didPushNext();
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   routeObserver.subscribe(this, ModalRoute.of(context)!);
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
            Navigator.of(context).pushNamed('/page2');
          }, child: Text('push to page 2')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('pop')),
        ),
      ],
    ),));
  }
}

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
            Navigator.of(context).pushNamed('/page3');
          }, child: Text('push to page 3')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('pop')),
        ),
      ],
    ),));
  }

}


class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: ElevatedButton(onPressed: (){
        //     Navigator.of(context).pushNamed('/page2');
        //   }, child: Text('push to page 2')),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('pop')),
        ),
      ],
    ),));
  }
}
