import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nearme/src/model/custome_container.dart';

class FavouritePlacesNotifier extends StateNotifier<List<CustomContainer>>{
  FavouritePlacesNotifier() : super([]);

  bool toggleFavouriteStatus(CustomContainer place){
    final placeIsFavourite = state.contains(place);

    if(placeIsFavourite){
      state = state.where((p) => p.title != place.title).toList();
      return false;
    }
    else{
      state = [...state , place];
      return true;
    }
  }
  void deleteFavouritePlace(CustomContainer place) {
    final placeIndex = state.indexWhere((p) => p.title == place.title);

    if (placeIndex != -1) {
      state = List.from(state)..removeAt(placeIndex);
    }
  }
}


final favouritePlaceProvider = StateNotifierProvider<FavouritePlacesNotifier ,List<CustomContainer>>((ref) => FavouritePlacesNotifier());