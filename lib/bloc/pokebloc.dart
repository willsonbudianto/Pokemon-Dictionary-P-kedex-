
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/pokestate.dart';
import 'package:pokemon_app/bloc/pokevent.dart';
import 'package:pokemon_app/data/repo.dart';

class PokeBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRepository = PokemonRepository();

  PokeBloc() : super(PokemonInitial());

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is PokemonPageRequest) {
      yield PokemonLoadInProgress();

      try {
        final pokemonPageResponse =
        await _pokemonRepository.getPokemonPage(event.page);
        yield PokemonPageLoadSuccess(
            pokemonListings: pokemonPageResponse.pokemonListings,
            canLoadNextPage: pokemonPageResponse.canLoadNextPage);
      } catch (e) {
        yield PokemonPageLoadFailed(error: e);
      }
    }
  }
}