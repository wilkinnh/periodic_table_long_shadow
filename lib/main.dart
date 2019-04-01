import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'elements.dart' as model;
import 'package:long_shadow/long_shadow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Periodic Table'),
      ),
      body: SafeArea(
        child: PeriodicTable(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PeriodicTable extends StatefulWidget {
  @override
  _PeriodicTableState createState() => _PeriodicTableState();
}

class _PeriodicTableState extends State<PeriodicTable> {
  List<dynamic> _list;

  @override
  void initState() {
    super.initState();
    fetchElements().then((list) {
      setState(() {
        _list = list;
      });
    });
  }

  Future<List<dynamic>> fetchElements() async {
    var response = await http
        .get('https://raw.githubusercontent.com/Bowserinator/Periodic-Table-JSON/master/PeriodicTableJSON.json');
    Map<String, dynamic> jsonData = json.decode(response.body);
    var jsonList = jsonData['elements'];
    print('loaded ${jsonList.length} elements');
    return jsonList;
  }

  @override
  Widget build(BuildContext context) {
    if (_list == null) {
      return Center(child: CircularProgressIndicator());
    }

//    return ListView.separated(
//      itemCount: _list.length,
//      itemBuilder: (BuildContext context, int index) {
//        Map<String, dynamic> element = _list[index];
//        return ListTile(
//          title: Text(element['name']),
//        );
//      },
//      separatorBuilder: (BuildContext context, int index) {
//        return Divider();
//      },
//    );

    var numberOfRows = _list
        .reduce((current, next) => ((current['ypos'] as int) > (next['ypos'] as int)) ? current : next)['ypos'] as int;
    var numberOfColumns = _list
        .reduce((current, next) => ((current['xpos'] as int) > (next['xpos'] as int)) ? current : next)['xpos'] as int;
    print('grid size: $numberOfColumns x $numberOfRows');

    var itemSize = Size(100, 100);

    return Scrollbar(
//          width: itemSize.width * numberOfColumns,
//          height: itemSize.height * numberOfRows,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: itemSize.width * numberOfColumns,
          child: GridView.count(
            crossAxisCount: numberOfColumns,
            padding: EdgeInsets.all(1),
            childAspectRatio: 1,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            shrinkWrap: true,
            children: List<Widget>.generate(numberOfRows * numberOfColumns, (index) {
//        print('list item index: $index');
              var row = index ~/ numberOfColumns;
              var column = index % numberOfColumns;
//        print('element index: ($column, $row)');
//        print('element index: (${column + 1}, ${row + 1})');
              var element = _list.firstWhere((element) {
                var elementRow = element['ypos'] as int;
                var elementColumn = element['xpos'] as int;
                return elementColumn == column + 1 && elementRow == row + 1;
              }, orElse: () {});

              if (element == null) {
                return Container();
              }

              return Container(
//                width: itemSize.width,
//                height: itemSize.height,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Text(
                        element['number'].toString(),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    LongShadow(
                      angle: -1,
                      color: Colors.black38,
                      text: Text(
                        element['symbol'],
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
