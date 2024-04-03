import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'info_screen_event.dart';
part 'info_screen_state.dart';

class InfoScreenBloc extends Bloc<InfoScreenEvent, InfoScreenState> {
  Timer? _timer;
  bool _isSwipingForward = true;

  static const autoSwipeDuration = Duration(seconds: 5);

  InfoScreenBloc() : super(const InfoScreenState()) {
    on<InfoScreenEvent>((event, emit) {});

    on<InitInfoScreenEvent>((event, emit) {
      _startAutoSwiping();
      _saveOptions();
    });

    on<PageChanged>((event, emit) {
      pageChanged(event);
      _startAutoSwiping();
    });
  }

  void _startAutoSwiping() {
    _timer?.cancel();
    _timer = Timer.periodic(autoSwipeDuration, (_) {
      if (state.selectedIndex == 0) _isSwipingForward = true;
      if (state.selectedIndex == 2) _isSwipingForward = false;
      if (_isSwipingForward) {
        int newIndex = state.selectedIndex + 1;
        if (newIndex >= 2) {
          _isSwipingForward = false;
        }
        add(PageChanged(newIndex));
      } else {
        int newIndex = state.selectedIndex - 1;
        if (newIndex <= 0) {
          _isSwipingForward = true;
        }
        add(PageChanged(newIndex));
      }
    });
  }

  Future<void> pageChanged(PageChanged event) async {
    emit(state.copyWith(selectedIndex: event.selectedIndex));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  _saveOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }
}
