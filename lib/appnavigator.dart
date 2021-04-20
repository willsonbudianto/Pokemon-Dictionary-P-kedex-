import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/pokeview.dart';
import 'package:pokemon_app/detailsview.dart';

import 'bloc/navigation.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NvCubit, int>(builder: (context, pokemonId) {
      return Navigator(
        pages: [
          MaterialPage(child: PokedexView()),
          if (pokemonId != null) MaterialPage(child: PokemonDetailsView())
        ],
        onPopPage: (route, result) {
          BlocProvider.of<NvCubit>(context).popToPokedex();
          return route.didPop(result);
        },
      );
    });
  }
}