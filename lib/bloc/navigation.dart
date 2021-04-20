import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/detailscubit.dart';

class NvCubit extends Cubit<int> {
  PokemonDetailsCubit pokemonDetailsCubit;

  NvCubit({@required this.pokemonDetailsCubit}) : super(null);

  void showPokemonDetails(int pokemonId) {
    print(pokemonId);
    pokemonDetailsCubit.getPokemonDetails(pokemonId);
    emit(pokemonId);
  }

  void popToPokedex() {
    emit(null);
    pokemonDetailsCubit.clearPokemonDetails();
  }
}