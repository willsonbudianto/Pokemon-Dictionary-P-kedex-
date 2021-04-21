import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/data/detail.dart';
import 'package:pokemon_app/data/responsepage.dart';

import 'bloc/navigation.dart';
import 'bloc/pokebloc.dart';
import 'bloc/pokestate.dart';

class PokedexView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Dictionary'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      body: BlocBuilder<PokeBloc, PokemonState>(
        builder: (context, state) {
          if (state is PokemonLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PokemonPageLoadSuccess) {
            return GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: state.pokemonListings.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => BlocProvider.of<NvCubit>(context)
                      .showPokemonDetails(state.pokemonListings[index].id),
                  child: Card(
                    child: GridTile(
                      child: Column(
                        children: [
                          Image.network(state.pokemonListings[index].imageUrl),
                          Text(state.pokemonListings[index].name)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is PokemonPageLoadFailed) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DataSearch extends SearchDelegate <String>{

  final pokemon = [
    "bulbasaur",
    "ivysaur",
    "venusaur",
    "chamandder",
    "charmeleon",
    "charizard",
    "squirtle",
    "wartortle",
    "blastoise"
  ];

  final recents = [
    "bulbasaur",
    "chamandder",
    "squirtle"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return[IconButton(icon: Icon(Icons.clear), onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation), onPressed: (){
      close(context, null);
    });

  }

  @override
  Widget buildResults(BuildContext context) {
    return Card(
      color: Colors.red,
      child: Center(
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty?recents:pokemon.where((p) => p.startsWith(query)).toList();

    return ListView.builder(itemBuilder: (context, index) => ListTile(
      onTap: (){
        showResults(context);
      },
      leading: Icon(Icons.circle),
      title: RichText(text: TextSpan(
          text: suggestionList[index].substring(0, query.length),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: [TextSpan(
              text: suggestionList[index].substring(query.length),
              style: TextStyle(color: Colors.grey)
          )]),
      ),
    ),
      itemCount: suggestionList.length,
    );
  }
}