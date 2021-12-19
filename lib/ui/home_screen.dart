import 'package:flutter/material.dart';
import 'package:query_builder_task/ui/widgets/query_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QueryItemWidget> queryItemWidget = [const QueryItemWidget()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
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
                  IconButton(
                      onPressed: () {
                        setState(() {
                          queryItemWidget
                              .add(const QueryItemWidget(firstWidget: false));
                        });
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.green,
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ...(queryItemWidget.map((e) {
                if (queryItemWidget.indexOf(e) == 0) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: e);
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: e),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                queryItemWidget.remove(e);
                              });
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  );
                }
              }).toList())
            ],
          ),
        ),
      ),
    );
  }
}
