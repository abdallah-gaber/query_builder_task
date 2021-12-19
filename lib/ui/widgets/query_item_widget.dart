import 'package:flutter/material.dart';
import 'package:query_builder_task/common/strings.dart';
import 'package:query_builder_task/models/query_model.dart';

class QueryItemWidget extends StatefulWidget {
  final bool firstWidget;
  final QueryModel queryModel = QueryModel();

  QueryItemWidget({this.firstWidget = true, Key? key}) : super(key: key);

  @override
  _QueryItemWidgetState createState() => _QueryItemWidgetState();
}

class _QueryItemWidgetState extends State<QueryItemWidget> {
  List<String> columnsNames = [
    ColumnNames.ID_COLUMN,
    ColumnNames.FIRST_NAME_COLUMN,
    ColumnNames.LAST_NAME_COLUMN,
    ColumnNames.FULL_NAME_COLUMN,
    ColumnNames.GENDER_COLUMN,
    ColumnNames.AGE_COLUMN,
  ];

  List<String> numberOperators = [
    NumberOperators.EQUALS,
    NumberOperators.NOT_EQUALS,
    NumberOperators.GREATER_THAN,
    NumberOperators.LESS_THAN,
  ];

  List<String> stringOperators = [
    StringOperators.STARTS_WITH,
    StringOperators.ENDS_WITH,
    StringOperators.CONTAINS,
    StringOperators.EXACT,
  ];

  String? selectedColumn;
  String? selectedOperator;

  @override
  void initState() {
    super.initState();
    selectedColumn = columnsNames[0];
    widget.queryModel.columnName = selectedColumn;
    selectedOperator = stringOperators[0];
    widget.queryModel.operator = selectedOperator;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                flex: selectedColumn == null || selectedColumn == "Age" ? 2 : 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: const Color(0xFFE5E5E5))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: columnsNames.map((item) {
                        return DropdownMenuItem<String>(
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 14),
                          ),
                          value: item,
                        );
                      }).toList(),
                      value: selectedColumn,
                      // hint: const Padding(
                      //   padding: EdgeInsets.all(8.0),
                      //   child: Text(
                      //     "Column Name",
                      //     style: TextStyle(fontSize: 14),
                      //   ),
                      // ),
                      onChanged: (value) {
                        setState(() {
                          selectedOperator =
                              ColumnNames.useNumberOperator(value!)
                                  ? numberOperators[0]
                                  : stringOperators[0];
                          selectedColumn = value;
                          widget.queryModel.columnName = value;
                        });
                      },
                    ),
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
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
                            : (ColumnNames.useNumberOperator(selectedColumn!)
                                ? numberOperators
                                : stringOperators))
                        .map((item) {
                      return DropdownMenuItem<String>(
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 14),
                        ),
                        value: item,
                      );
                    }).toList(),
                    value: selectedOperator,
                    // hint: const Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Text(
                    //     "Operator",
                    //     style: TextStyle(fontSize: 14),
                    //   ),
                    // ),
                    onChanged: (value) {
                      setState(() {
                        selectedOperator = value;
                        widget.queryModel.operator = value;
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
            keyboardType: TextInputType.text,
            onChanged: (data) {
              setState(() {
                widget.queryModel.data = data;
              });
            },
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
