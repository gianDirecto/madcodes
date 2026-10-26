import 'package:flutter/material.dart';

class TodoNewst extends StatefulWidget {
  const TodoNewst({super.key});

  @override
  State<TodoNewst> createState() => _TodoNewstState();
}

class _TodoNewstState extends State<TodoNewst> {
  var items = [];

  var itemCtrl = TextEditingController();

  void addItem() {
    setState(() {
      if (itemCtrl.text != "") items.add(itemCtrl.text);
      itemCtrl.clear();
      print(items);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Todo List"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: .endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: TextField(
                controller: itemCtrl,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    addItem();
                    Navigator.of(context).pop();
                  },
                  child: Text("Add"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
              ],
              title: Text('Confirm to add'),
            ),
          );
        },
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Expanded(child: TextField(controller: itemCtrl)),
              //     SizedBox(width: 12),
              //     GestureDetector(
              //       child: CircleAvatar(child: Icon(Icons.add)),
              //       onTap: addItem,
              //     ),
              //     // may ripple effect
              //     // InkWell(
              //     //   child: CircleAvatar(child: Icon(Icons.add)),
              //     //   onTap: addItem,
              //     // ),
              //   ],
              // ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(color: Colors.red),
                      secondaryBackground: Container(
                        padding: .only(right: 18),
                        color: Colors.red,
                        alignment: .centerEnd,
                        child: Icon(Icons.delete, color: Colors.red),
                      ),
                      direction: .endToStart,
                      onDismissed: (direction) {
                        // if(direction == DismissDirection.endToStart)
                        var removedItem = items.removeAt(index);
                        setState(() {});
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 3),
                            content: Text('Item ${removedItem} deleted.'),
                            action: SnackBarAction(
                              label: 'UNDO',
                              onPressed: () {
                                // items.add(removedItem);
                                items.insert(index, removedItem);
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      },
                      confirmDismiss: (direction) async {
                        // if(direction == DismissDirection.endToStart)
                        final result = await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: Text('Do you want to delete this item?'),
                            title: Text('Confirm to delete'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop('yes');
                                },
                                child: Text('YES'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          ),
                        );
                        print(result);
                        if (result == null) return false;
                        return true;
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(items[index]),
                          // subtitle: Text('Sub'),
                          leading: CircleAvatar(child: Text("${index + 1}")),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}