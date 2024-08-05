import 'package:flutter_load_more_list/model/my_data_item.dart';
import 'package:loading_more_list/loading_more_list.dart';

class MyDataSource extends LoadingMoreBase<MyDataItem> {
  int _page = 1;
  bool _hasMore = true;
  bool forceRefresh = false;
  int i =0;
  bool isSuccess = false;

  @override
  bool get hasMore => ( length < 35) || forceRefresh;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    _page = 1;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    forceRefresh = !notifyStateChanged;
    var result = await super.refresh(notifyStateChanged);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadMore() async{
    print('loadMore method called ${i++} times');
    print(_page);
      try {
        // محاكاة جلب البيانات من الإنترنت
       await Future.delayed(Duration(seconds: 2));
       final newData = List.generate(20, (index) => MyDataItem('Item '));
        if (newData.isNotEmpty) {
          addAll(newData);
          _page++;
          isSuccess = true;
        }
      } catch (error) {
        // التعامل مع الخطأ
        print('there is an error $error');
      }
      print('```````````````````````super.loadMore()```````````````````````');
      print(await super.loadMore());
    return isSuccess;
  }
  // @override
  // Future<bool> loadMore() async {
  //   print('loadMore method called ${i++} times');
  //   try {
  //     // محاكاة جلب البيانات من الإنترنت
  //    await Future.delayed(Duration(seconds: 2));
  //    final newData = List.generate(20, (index) => MyDataItem('Item ${(_page - 1) * 10 + index + 1}'));
  //     if (newData.isNotEmpty) {
  //       addAll(newData);
  //       _page++;
  //       isSuccess = false;
  //     }
  //   } catch (error) {
  //     // التعامل مع الخطأ
  //     print('there is an error $error');
  //   }
  //   return isSuccess;
  // }

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    print(' لود داتا loadData method called ${i++} times');

    _page = 1; // إعادة تعيين الصفحة إلى 1
    clear(); // مسح البيانات الحالية
    return await loadMore();
  }
}
