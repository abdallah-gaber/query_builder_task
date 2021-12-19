import 'package:flutter/material.dart';

class QueryItemWidget extends StatefulWidget {
  final bool firstWidget;

  const QueryItemWidget({this.firstWidget = true, Key? key}) : super(key: key);

  @override
  _QueryItemWidgetState createState() => _QueryItemWidgetState();
}

class _QueryItemWidgetState extends State<QueryItemWidget> {
  List<String> columnsNames = [
    "First Name",
    "Last Name",
    "Full Name",
    "Gender",
    "Age"
  ];
  List<String> numberOperators = ["=", "!=", ">", "<"];
  List<String> stringOperators = [
    "Starts with",
    "Ends with",
    "Contains",
    "Exact"
  ];
  String? selectedColumn;
  String? selectedOperator;
  TextEditingController dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: const Color(0xFFE5E5E5))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  items: columnsNames.map((item) {
                    return DropdownMenuItem<String>(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  value: selectedColumn,
                  hint: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Column Name"),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedColumn = value;
                    });
                  },
                ),
              ),
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: const Color(0xFFE5E5E5))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    items: (selectedColumn == null
                            ? []
                            : (selectedColumn == "Age"
                                ? numberOperators
                                : stringOperators))
                        .map((item) {
                      return DropdownMenuItem<String>(
                        child: Text(item),
                        value: item,
                      );
                    }).toList(),
                    value: selectedOperator,
                    hint: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Operator"),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedOperator = value;
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: const Color(0xFFE5E5E5))),
          child: TextField(
            controller: dataController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Data',
            ),
          ),
        ),
      ],
    );
  }
}
