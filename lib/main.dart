import 'package:flutter/material.dart';
import 'package:flutter_load_more_list/model/my_data_item.dart';
import 'package:flutter_load_more_list/my_data_source.dart';
import 'package:loading_more_list/loading_more_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required String title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyDataSource _myDataSource = MyDataSource();
int i =0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Loading more list'),
        ),
        body: LoadingMoreList<MyDataItem>(ListConfig<MyDataItem>(
          extendedListDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          reverse: true,
          sourceList: _myDataSource,
          itemBuilder: (context, item, index) {
            // print(index);
            return ListTile(
              title: Text('${item.title} ${i++}'),
            );
          },
          indicatorBuilder: (context, status) {
            print(IndicatorStatus.values);

            if (status == IndicatorStatus.fullScreenBusying) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (status == IndicatorStatus.noMoreLoad) {
              return Center(
                child: Text('No more items to load'),
              );
            } else if (status == IndicatorStatus.loadingMoreBusying){
              return  Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
            return Center(
            child: Text('Error occurred while loading'),
            );
            }
          },
          addAutomaticKeepAlives: true,
        )),
      ),
    );
  }
}
