import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/grate_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GratePlaces>(context, listen: false).fetchAndSetPlaces(),
          builder:(ctx,snapshot)=> snapshot.connectionState == ConnectionState.waiting ?
          Center(
            child: CircularProgressIndicator(),
          )
           : Consumer<GratePlaces>(
          child: Center(child: const Text('Get no places yet, start adding some!')),
          builder: (ctx, gratePlaces,ch)=> gratePlaces.items.length <=0 ? 
          ch : ListView.builder(
            itemCount: gratePlaces.items.length,
            itemBuilder: (ctx,i)=>ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(
                  gratePlaces.items[i].image,
                ),
              ),
              title:  Text(gratePlaces.items[i].title),
              onTap: (){},
            ),
          ),
        ),
      ),
    );
  }
}
