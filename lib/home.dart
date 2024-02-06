import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final TextEditingController name = TextEditingController();
  final TextEditingController quantity = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _showsheet(BuildContext ctx, int? itemKey) {
    showModalBottomSheet(
        context: ctx,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding:
                  EdgeInsets.only(bottom: 10, top: 15, left: 15, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: name,
                    decoration: InputDecoration(hintText: "name"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: quantity,
                    decoration: InputDecoration(hintText: "quandity"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (itemKey == null) {}
                          if (itemKey != null) {}
                        },
                        child: Text(itemKey == null ? "add" : "update")),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TO DO APP"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, index) {
            return Card(
              color: Colors.green.shade200,
              margin: EdgeInsets.all(10),
              elevation: 3,
              child: ListTile(
                //     title: Text(currentItem['name']),
                //   subtitle: Text(currentItem['quandity'].toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          //        _showsheet(context, currentItem["key"]);
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          //   deleteItem(currentItem["key"]);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showsheet(context, null);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
