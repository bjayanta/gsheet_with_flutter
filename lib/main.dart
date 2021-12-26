import 'package:flutter/material.dart';
import 'package:maxsopian/api/sheets/maxsopian_sheets_api.dart';
import 'package:maxsopian/screen/create_sheets_page.dart';
import 'package:maxsopian/screen/modify_sheets_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MaxsopianSheetApi.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  final pages = [
    CreateSheetsPage(),
    ModifySheetsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const CreateSheetsPage(),
      home: Scaffold(
        body: pages[index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          destinations: [
            NavigationDestination(
                icon: Text("Create"),
                label: "Home page"
            ),
            NavigationDestination(
                icon: Text("Modify"),
                label: "Modify page"
            ),
          ],
        ),
      ),
    );
  }
}