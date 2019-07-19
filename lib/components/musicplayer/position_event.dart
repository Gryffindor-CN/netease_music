import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

class Player {
  static final EventBus eventBus = EventBus();
  static final EventBus idEventBus = EventBus();
  static handleMusicPosFire(double) {
    eventBus.fire(double);
  }

  static handleSongidFire(int) {
    eventBus.fire(int);
  }
}
