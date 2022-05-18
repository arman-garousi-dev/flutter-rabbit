part of 'main_cubit.dart';

class MainState extends Equatable {
  final bool isPlaying;
  final bool isMoving;
  final int distanceTimerNumber;
  final int gameOverTimerNumber;

  const MainState({
    required this.isPlaying,
    required this.isMoving,
    required this.distanceTimerNumber,
    required this.gameOverTimerNumber,
  });

  MainState copyWith({
    bool? isPlaying,
    bool? isMoving,
    int? distanceTimerNumber,
    int? gameOverTimerNumber,
  }) {
    return MainState(
      isPlaying: isPlaying ?? this.isPlaying,
      isMoving: isMoving ?? this.isMoving,
      distanceTimerNumber: distanceTimerNumber ?? this.distanceTimerNumber,
      gameOverTimerNumber: gameOverTimerNumber ?? this.gameOverTimerNumber,
    );
  }

  @override
  List<Object?> get props =>
      [isPlaying, isMoving, distanceTimerNumber, gameOverTimerNumber];

  @override
  bool? get stringify => true;
}
