import 'package:flutter/material.dart';

class ExpansionList extends StatefulWidget {
  const ExpansionList({Key key}) : super(key: key);

  @override
  _ExpansionListState createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList> {
  List<Item> _data = generateItems(10);

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(title: Text('Delete item?'), actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                  },
                  child: const Text('OK'))
            ]));
  }

  Widget _buildListPanel() {
    return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data[index].isExpanded = !isExpanded;
          });
        },
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.headerValue),
                );
              },
              body: ListTile(
                  title: Text(item.expandedValue),
                  subtitle: Text('description'),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        //remove from database
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                    title: Text('Delete item?'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'Cancel');
                                          },
                                          child: const Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'OK');
                                            setState(() {
                                              _data.removeWhere((currentItem) =>
                                                  item == currentItem);
                                            });
                                          },
                                          child: const Text('OK'))
                                    ]));
                      })),
              isExpanded: item.isExpanded);
        }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: _buildListPanel(),
    ));
  }
}

class Item {
  String expandedValue;
  String headerValue;
  bool isExpanded;

  Item({this.expandedValue, this.headerValue, this.isExpanded = false});
}

List<Item> generateItems(int numItems) {
  return List.generate(numItems, (index) {
    return Item(
        headerValue: 'Company $index', expandedValue: 'Furniture $index');
  });
}
