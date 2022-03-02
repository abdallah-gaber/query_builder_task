import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:query_builder_task/common/strings.dart';
import 'package:query_builder_task/models/query_model.dart';
import 'package:query_builder_task/ui/filter_result_screen.dart';
import 'package:query_builder_task/ui/widgets/query_item_widget.dart';

import '../main.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<QueryItemWidget> queryItemWidget = [QueryItemWidget()];
  List<String> logicOperators = [LogicOperators.AND, LogicOperators.OR];
  late List<String> selectedLogicOperator = [];

  final _animatedListKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    initProviders();
  }

  initProviders() async {
    await ref.read(allFakeUsersProvider.future);
    ref.read(userProvider);
  }

  @override
  Widget build(BuildContext context) {
    final isThereConnectionFlag = ref.watch(isThereInternet);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 61,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                        "Query Builder",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 32),
                      )),
                      // if (queryItemWidget.length != 2)
                      IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            queryItemWidget
                                .add(QueryItemWidget(firstWidget: false));
                            selectedLogicOperator.add(logicOperators[0]);
                            _animatedListKey.currentState!
                                .insertItem(queryItemWidget.length - 1);
                          },
                          icon: Image.asset(
                            'assets/add.png',
                            height: 28,
                            width: 28,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  AnimatedList(
                      key: _animatedListKey,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      initialItemCount: queryItemWidget.length,
                      itemBuilder: (context, index, animation) {
                        if (index == 0) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF7F7F7),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: queryItemWidget[index]),
                            ],
                          );
                        } else {
                          return SizeTransition(
                            sizeFactor: animation,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  width: MediaQuery.of(context).size.width / 4,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                      border: Border.all(
                                          color: const Color(0x33808080))),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      items: logicOperators.map((item) {
                                        return DropdownMenuItem<String>(
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          value: item,
                                        );
                                      }).toList(),
                                      value: selectedLogicOperator[index - 1],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedLogicOperator[index - 1] =
                                              value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF7F7F7),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(child: queryItemWidget[index]),
                                      IconButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            var removedItem =
                                                queryItemWidget[index];
                                            queryItemWidget.removeAt(index);
                                            selectedLogicOperator.removeAt(index -
                                                1); // because it's starting from the second item
                                            AnimatedList.of(context).removeItem(
                                                index,
                                                (context, animation) =>
                                                    SizeTransition(
                                                      sizeFactor: animation,
                                                      child: removedItem,
                                                    ));
                                          },
                                          icon: Image.asset(
                                            'assets/remove.png',
                                            height: 28,
                                            width: 28,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    width: MediaQuery.of(context).size.width,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFF2D9CDB),
                      ),
                      child: TextButton(
                          onPressed: () {
                            _onSearchPressed();
                          },
                          child: Image.asset(
                            'assets/search.png',
                            height: 28,
                            width: 28,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: (isThereConnectionFlag.value != null && !isThereConnectionFlag.value!)
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(top: 40),
                      decoration: const BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: const Text('No Internet Connection'),
                    ),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  _onSearchPressed() async {
    FocusScope.of(context).unfocus();
    final isThereConnectionFlag =
        (await InternetConnectionChecker().connectionStatus) ==
            InternetConnectionStatus.connected;
    if (validateData()) {
      if (!isThereConnectionFlag) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
            content: const Text("No Internet Connection and Data didn't load"),
            action: SnackBarAction(
                label: 'Retry',
                onPressed: () {
                  _onSearchPressed();
                }),
          ));
      } else if (isThereConnectionFlag &&
          ref.read(userProvider).allFakeUsersList.isEmpty) {
        ref.refresh(userProvider);
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
            content: const Text("Data didn't load yet"),
            action: SnackBarAction(
                label: 'Retry',
                onPressed: () {
                  _onSearchPressed();
                }),
          ));
      } else {
        ref
            .read(userProvider)
            .filterUsersList(collectData(), selectedLogicOperator);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const FilterResultScreen()));
      }
    }
  }

  bool validateData() {
    for (QueryItemWidget qiw in queryItemWidget) {
      if (qiw.queryModel.data == null || qiw.queryModel.data!.isEmpty) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(const SnackBar(content: Text("You must Enter Data")));
        return false;
      }
    }

    return true;
  }

  List<QueryModel> collectData() {
    List<QueryModel> qm = [];
    for (QueryItemWidget qiw in queryItemWidget) {
      qm.add(qiw.queryModel);
    }
    return qm;
  }
}
