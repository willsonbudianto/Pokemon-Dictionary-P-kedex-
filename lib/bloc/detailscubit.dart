import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/data/detail.dart';
import 'package:pokemon_app/data/inforesp.dart';
import 'package:pokemon_app/data/species.dart';
import 'package:pokemon_app/data/repo.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetails> {
  final _pokemonRepository = PokemonRepository();

  PokemonDetailsCubit() : super(null);

  void getPokemonDetails(int pokemonId) async {
    final responses = await Future.wait([
      _pokemonRepository.getPokemonInfo(pokemonId),
      _pokemonRepository.getPokemonSpeciesInfo(pokemonId)
    ]);

    final pokemonInfo = responses[0] as PokemonInfoResponse;
    final speciesInfo = responses[1] as PokemonSpeciesInfoResponse;

    emit(PokemonDetails(
        id: pokemonInfo.id,
        name: pokemonInfo.name,
        imageUrl: pokemonInfo.imageUrl,
        types: pokemonInfo.types,
        height: pokemonInfo.height,
        weight: pokemonInfo.weight,
        description: speciesInfo.description));
  }

  void clearPokemonDetails() => emit(null);
}