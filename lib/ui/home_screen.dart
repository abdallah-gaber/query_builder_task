import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Query Builder",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
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
                        icon: const Icon(
                          CupertinoIcons.add_circled,
                          color: Colors.green,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                width: MediaQuery.of(context).size.width / 4,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    border: Border.all(
                                        color: const Color(0xFFE5E5E5))),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    items: logicOperators.map((item) {
                                      return DropdownMenuItem<String>(
                                        child: Text(
                                          item,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        value: item,
                                      );
                                    }).toList(),
                                    value: selectedLogicOperator[index - 1],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedLogicOperator [index - 1] = value!;
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
                                          selectedLogicOperator.removeAt(index - 1); // because it's starting from the second item
                                          AnimatedList.of(context).removeItem(
                                              index,
                                              (context, animation) =>
                                                  SizeTransition(
                                                    sizeFactor: animation,
                                                    child: removedItem,
                                                  )
                                              );
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.red,
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
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFF2D9CDB),
                    ),
                    child: TextButton(
                        onPressed: () {
                          if (validateData()) {
                            ref.read(userProvider).filterUsersList(
                                collectData(),
                                selectedLogicOperator);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const FilterResultScreen()));
                          }
                        },
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.search,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateData() {
    for (QueryItemWidget qiw in queryItemWidget) {
      if (qiw.queryModel.data == null || qiw.queryModel.data!.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("You must Enter Data")));
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
