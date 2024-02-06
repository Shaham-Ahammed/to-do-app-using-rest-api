// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:to_do_app_api_connected/alert_dialoges.dart';

import 'package:to_do_app_api_connected/api_cred_methods.dart';

final TextEditingController titleController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
        fetchData();
    super.initState();

  }

  bool isLoading = true;
  List<dynamic> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("TO DO APP"),
        centerTitle: true,
        backgroundColor: Colors.green.shade200,
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: () => fetchData(),
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final id = item['_id'];
                return Card(
                  color: Colors.green.shade200,
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                    title: Text(item['title']),
                    subtitle: Text(item['description']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              _showsheet(context, id, index);
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              deleteById(id, context, ()async {
                              await  fetchData();
                                  deleteSuccessMessage(context);
                              });
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                );
              }),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showsheet(context, null, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showsheet(BuildContext ctx, String? id, int? index) {
    if (id != null) {
      titleController.text = items[index!]['title'];
      descriptionController.text = items[index]['description'];
    }
    showModalBottomSheet(
        context: ctx,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                    top: 15,
                    left: 15,
                    right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(hintText: "title"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(hintText: "description"),
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                });
                            try {
                              id == null
                                  ? submitData(ctx, ()async {
                                     await fetchData();
                                      successMessage(context);
                                    })
                                  : updateData(id, ctx, ()async {
                                     await fetchData();
                                       updateSuccessMessage(context);
                                    });
                            } catch (error) {
                              debugPrint("Error: $error");
                            }
                          },
                          child: Text(id == null ? "add" : "update")),
                    )
                  ],
                ),
              ),
            ));
  }

  fetchData() async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        items = json['items'];
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
