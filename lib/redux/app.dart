import 'collection.dart';
import '../model/music.dart';

enum NeteaseActions { AddToCollection, AddToRecentPlay, AddToRadio, AddToLocal }

NeteaseState appReducer(NeteaseState state, dynamic action) {
  print(action);
  if (action == NeteaseActions.AddToCollection) {
    return NeteaseState(
        collectionState: Collection(
            myCollection: state.collectionState.myCollection + 1,
            myRadio: state.collectionState.myRadio,
            myLocal: state.collectionState.myLocal,
            recentPlay: state.collectionState.recentPlay));
  } else if (action is UpdateRecentPlayAction) {
    if (action.flag == true) {
      return NeteaseState(
          collectionState: Collection(
              myCollection: state.collectionState.myCollection,
              myRadio: state.collectionState.myRadio,
              myLocal: state.collectionState.myLocal,
              recentPlay: state.collectionState.recentPlay + 1));
    } else {
      return NeteaseState(
          collectionState: Collection(
              myCollection: state.collectionState.myCollection,
              myRadio: state.collectionState.myRadio,
              myLocal: state.collectionState.myLocal,
              recentPlay: state.collectionState.recentPlay));
    }
  } else if (action == NeteaseActions.AddToRadio) {
    return NeteaseState(
        collectionState: Collection(
            myCollection: state.collectionState.myCollection,
            myRadio: state.collectionState.myRadio + 1,
            myLocal: state.collectionState.myLocal,
            recentPlay: state.collectionState.recentPlay));
  } else if (action == NeteaseActions.AddToLocal) {
    return NeteaseState(
        collectionState: Collection(
            myCollection: state.collectionState.myCollection,
            myRadio: state.collectionState.myRadio,
            myLocal: state.collectionState.myLocal + 1,
            recentPlay: state.collectionState.recentPlay));
  }

  return state;
}

class NeteaseState {
  Collection collectionState;
  NeteaseState({Collection collectionState}) {
    this.collectionState = collectionState;
  }

  static Future<NeteaseState> initial() async {
    var collectionState = await Collection.initial();
    return NeteaseState(collectionState: collectionState);
  }
}

class AddToRecentPlayAction {
  final Music music;
  AddToRecentPlayAction(this.music);
}

class UpdateRecentPlayAction {
  final bool flag;
  UpdateRecentPlayAction({this.flag});
}
