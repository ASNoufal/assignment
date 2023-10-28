import 'package:assignment/presentation/Navigatingscreen/navigatingscreen.dart';
import 'package:flutter/material.dart';

List retailstore = ["a shop", "b shop", "cshop"];

class RetailStore extends StatelessWidget {
  const RetailStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () {
            context.navigationtoscreen(
                child: RetailStoredata(), isreplace: true);
          },
          child: Text("Add Retailer")),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(retailstore[index]),
            ),
          );
        },
        itemCount: retailstore.length,
      ),
    );
  }
}

class RetailStoredata extends StatelessWidget {
  const RetailStoredata({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Retailstore")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Enter the Retailer name"),
            ),
          )
        ],
      ),
    );
  }
}
