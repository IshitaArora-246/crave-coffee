import 'package:crave_coffee/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);

    brews.forEach((brew) {
      print("${brew.name}\n${brew.strength}\n${brew.sugars}");
    });

    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return BrewTile(brew: brews[index]);
        });
  }
}

class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile({this.brew});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.brown[brew.strength],
                backgroundImage: AssetImage('assets/coffee_icon.png'),
              ),
              title: Text(brew.name),
              subtitle: Text("Takes ${brew.sugars} sugar(s)"),
            )));
  }
}
