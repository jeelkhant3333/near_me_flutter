import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nearme/src/model/custome_container.dart';

class SavedPlacesNotifier extends StateNotifier<List<CustomContainer>>{
  SavedPlacesNotifier() : super([]);

  bool toggleSaveStatus(CustomContainer place){
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
  void deleteSavePlace(CustomContainer place) {
    final placeIndex = state.indexWhere((p) => p.title == place.title);

    if (placeIndex != -1) {
      state = List.from(state)..removeAt(placeIndex);
    }
  }
}


final savedPlaceProvider = StateNotifierProvider<SavedPlacesNotifier ,List<CustomContainer>>((ref) => SavedPlacesNotifier());