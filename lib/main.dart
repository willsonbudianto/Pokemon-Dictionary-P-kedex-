import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/appnavigator.dart';
import 'package:pokemon_app/bloc/navigation.dart';
import 'package:pokemon_app/bloc/pokebloc.dart';
import 'package:pokemon_app/bloc/pokevent.dart';

import 'bloc/detailscubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokemonDetailsCubit = PokemonDetailsCubit();
    return MaterialApp(
      theme: Theme.of(context)
          .copyWith(primaryColor: Colors.deepPurple, accentColor: Colors.deepPurpleAccent),
      home: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
            PokeBloc()..add(PokemonPageRequest(page: 0))),
        BlocProvider(
            create: (context) =>
                NvCubit(pokemonDetailsCubit: pokemonDetailsCubit)),
        BlocProvider(create: (context) => pokemonDetailsCubit)
      ], child: AppNavigator()),
      debugShowCheckedModeBanner: false,
    );
  }
}