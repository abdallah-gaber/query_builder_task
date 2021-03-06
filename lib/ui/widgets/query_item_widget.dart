import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  TextEditingController dataTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedColumn = columnsNames[0];
    widget.queryModel.columnName = selectedColumn;
    selectedOperator = numberOperators[0];
    widget.queryModel.operator = selectedOperator;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
                flex: (selectedColumn == null ||
                        ColumnNames.useNumberOperator(selectedColumn!))
                    ? 2
                    : 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: const Color(0x33808080))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: columnsNames.map((item) {
                        return DropdownMenuItem<String>(
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          value: item,
                        );
                      }).toList(),
                      value: selectedColumn,
                      onChanged: (value) {
                        setState(() {
                          if(ColumnNames.useNumberOperator(value!) != ColumnNames.useNumberOperator(selectedColumn!)){
                            dataTextEditingController.clear();
                            setState(() {
                              widget.queryModel.data = "";
                            });
                          }
                          selectedOperator =
                              ColumnNames.useNumberOperator(value)
                                  ? numberOperators[0]
                                  : stringOperators[0];
                          widget.queryModel.operator = selectedOperator;
                          selectedColumn = value;
                          widget.queryModel.columnName = value;
                        });
                      },
                    ),
                  ),
                )),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: const Color(0x33808080))),
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
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(color: const Color(0x33808080))),
          child: TextField(
            controller: dataTextEditingController,
            keyboardType: ColumnNames.useNumberOperator(selectedColumn!) ? TextInputType.number : TextInputType.text,
            inputFormatters: ColumnNames.useNumberOperator(selectedColumn!) ? (<TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ] ) : null,
            onChanged: (data) {
              setState(() {
                widget.queryModel.data = data;
              });
            },
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Data',
              hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}
