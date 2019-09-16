import 'collection.dart';
import 'context.dart';
import '../model/music.dart';
import 'package:flutter/widgets.dart';

enum NeteaseActions { AddToCollection, AddToRecentPlay, AddToRadio, AddToLocal }

NeteaseState appReducer(NeteaseState state, dynamic action) {
  if (action == NeteaseActions.AddToCollection) {
    return NeteaseState(
        pagecontextState: state.pagecontextState,
        collectionState: Collection(
            myCollection: state.collectionState.myCollection + 1,
            myRadio: state.collectionState.myRadio,
            myLocal: state.collectionState.myLocal,
            recentPlay: state.collectionState.recentPlay));
  } else if (action is UpdateRecentPlayAction) {
    if (action.flag == true) {
      return NeteaseState(
          pagecontextState: state.pagecontextState,
          collectionState: Collection(
              myCollection: state.collectionState.myCollection,
              myRadio: state.collectionState.myRadio,
              myLocal: state.collectionState.myLocal,
              recentPlay: state.collectionState.recentPlay + 1));
    } else {
      return NeteaseState(
          pagecontextState: state.pagecontextState,
          collectionState: Collection(
              myCollection: state.collectionState.myCollection,
              myRadio: state.collectionState.myRadio,
              myLocal: state.collectionState.myLocal,
              recentPlay: state.collectionState.recentPlay));
    }
  } else if (action == NeteaseActions.AddToRadio) {
    return NeteaseState(
        pagecontextState: state.pagecontextState,
        collectionState: Collection(
            myCollection: state.collectionState.myCollection,
            myRadio: state.collectionState.myRadio + 1,
            myLocal: state.collectionState.myLocal,
            recentPlay: state.collectionState.recentPlay));
  } else if (action == NeteaseActions.AddToLocal) {
    return NeteaseState(
        pagecontextState: state.pagecontextState,
        collectionState: Collection(
            myCollection: state.collectionState.myCollection,
            myRadio: state.collectionState.myRadio,
            myLocal: state.collectionState.myLocal + 1,
            recentPlay: state.collectionState.recentPlay));
  } else if (action is RecordPageContextAction) {
    return NeteaseState(
        collectionState: state.collectionState,
        pagecontextState: PagecontextState(context: action.context));
  }

  return state;
}

class NeteaseState {
  Collection collectionState;
  PagecontextState pagecontextState;
  NeteaseState(
      {Collection collectionState, PagecontextState pagecontextState}) {
    this.collectionState = collectionState;
    this.pagecontextState = pagecontextState;
  }

  static Future<NeteaseState> initial() async {
    var collectionState = await Collection.initial();
    var pagecontextState = PagecontextState();
    return NeteaseState(
        collectionState: collectionState, pagecontextState: pagecontextState);
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

class RecordPageContextAction {
  BuildContext context;
  RecordPageContextAction(this.context);
}
