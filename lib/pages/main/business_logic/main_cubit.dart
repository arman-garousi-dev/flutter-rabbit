import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit()
      : super(
          const MainState(
            isPlaying: true,
            isMoving: false,
            distanceTimerNumber: 0,
            gameOverTimerNumber: 10,
          ),
        );

  @override
  Future<void> close() async {
    _gameOverTimer?.cancel();
    _distanceTimer?.cancel();

    return super.close();
  }

  Timer? _distanceTimer;
  Timer? _gameOverTimer;

  void move() {
    _gameOverTimer?.cancel();

    final newState = state.copyWith(
      isMoving: true,
      gameOverTimerNumber: 10,
    );
    emit(newState);

    _distanceTimer = Timer.periodic(
      const Duration(milliseconds: 1),
      (_) {
        final timerNewState = state.copyWith(
          distanceTimerNumber: state.distanceTimerNumber + 1,
        );
        emit(timerNewState);
      },
    );
  }

  void stop() {
    _distanceTimer?.cancel();

    final newState = state.copyWith(
      isMoving: false,
    );
    emit(newState);

    _gameOverTimer = Timer.periodic(
      const Duration(seconds: 1),
      (localGameOverTimer) {
        if (state.gameOverTimerNumber == 1) {
          localGameOverTimer.cancel();
          final timerNewState = state.copyWith(
            distanceTimerNumber: 0,
          );
          emit(timerNewState);
        }

        final timerNewState = state.copyWith(
          gameOverTimerNumber: state.gameOverTimerNumber - 1,
          isPlaying: state.gameOverTimerNumber > 1,
        );
        emit(timerNewState);
      },
    );
  }

  void retry() {
    final newState = state.copyWith(
      isPlaying: true,
      gameOverTimerNumber: 10,
    );
    emit(newState);
  }
}
