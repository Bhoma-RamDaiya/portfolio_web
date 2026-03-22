import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorCatcherBloc extends Cubit<ColorCatcherState> {
  ColorCatcherBloc() : super(ColorCatcherState.initial());

  final Random _random = Random();
  Timer? _timer;

  void startGame() {
    _timer?.cancel();
    emit(ColorCatcherState.initial());

    _timer = Timer.periodic(const Duration(milliseconds: 800), (_) {
      if (state.isGameOver) return;

      final newBall = FallingBall(
        x: _random.nextDouble(),
        color: BallColors.values[_random.nextInt(BallColors.values.length)],
      );

      emit(state.copyWith(
        balls: [...state.balls, newBall],
      ));
    });
  }

  void updateBasket(double x) {
    emit(state.copyWith(basketX: x));
  }

  void tick(double screenHeight) {
    if (state.isGameOver) return;

    final updatedBalls = <FallingBall>[];
    int score = state.score;
    int lives = state.lives;

    for (final ball in state.balls) {
      final newY = ball.y + 0.05;

      if (newY >= 0.9) {
        // Missed
        lives--;
      } else {
        updatedBalls.add(ball.copyWith(y: newY));
      }
    }

    if (lives <= 0) {
      emit(state.copyWith(
        lives: 0,
        isGameOver: true,
      ));
      _timer?.cancel();
    } else {
      emit(state.copyWith(
        balls: updatedBalls,
        score: score,
        lives: lives,
      ));
    }
  }

  void catchBall(FallingBall ball) {
    emit(state.copyWith(
      balls: state.balls.where((b) => b != ball).toList(),
      score: state.score + 10,
    ));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

/// =======================
/// STATE
/// =======================

class ColorCatcherState {
  final List<FallingBall> balls;
  final double basketX;
  final int score;
  final int lives;
  final bool isGameOver;

  ColorCatcherState({
    required this.balls,
    required this.basketX,
    required this.score,
    required this.lives,
    required this.isGameOver,
  });

  factory ColorCatcherState.initial() => ColorCatcherState(
    balls: [],
    basketX: 0.5,
    score: 0,
    lives: 3,
    isGameOver: false,
  );

  ColorCatcherState copyWith({
    List<FallingBall>? balls,
    double? basketX,
    int? score,
    int? lives,
    bool? isGameOver,
  }) {
    return ColorCatcherState(
      balls: balls ?? this.balls,
      basketX: basketX ?? this.basketX,
      score: score ?? this.score,
      lives: lives ?? this.lives,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }
}

/// =======================
/// MODEL
/// =======================

enum BallColors { red, blue, green }

extension BallColorX on BallColors {
  Color get color {
    switch (this) {
      case BallColors.red:
        return Colors.redAccent;
      case BallColors.blue:
        return Colors.blueAccent;
      case BallColors.green:
        return Colors.greenAccent;
    }
  }
}

class FallingBall {
  final double x;
  final double y;
  final BallColors color;

  FallingBall({
    required this.x,
    this.y = 0,
    required this.color,
  });

  FallingBall copyWith({double? y}) {
    return FallingBall(
      x: x,
      y: y ?? this.y,
      color: color,
    );
  }
}

/// =======================
/// GAME WIDGET
/// =======================

class ColorCatcherGame extends StatefulWidget {
  const ColorCatcherGame({super.key});

  @override
  State<ColorCatcherGame> createState() => _ColorCatcherGameState();
}

class _ColorCatcherGameState extends State<ColorCatcherGame>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();

    _ticker = createTicker((_) {
      context.read<ColorCatcherBloc>().tick(MediaQuery.of(context).size.height);
    })..start();

    context.read<ColorCatcherBloc>().startGame();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorCatcherBloc, ColorCatcherState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF0F172A),
          body: Stack(
            children: [
              // Balls
              ...state.balls.map((ball) {
                return Positioned(
                  left: ball.x * MediaQuery.of(context).size.width,
                  top: ball.y * MediaQuery.of(context).size.height,
                  child: GestureDetector(
                    onTap: () =>
                        context.read<ColorCatcherBloc>().catchBall(ball),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: ball.color.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }),

              // Basket
              Positioned(
                bottom: 40,
                left: state.basketX * MediaQuery.of(context).size.width - 40,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    final newX =
                    (details.localPosition.dx / MediaQuery.of(context).size.width)
                        .clamp(0.0, 1.0);
                    context.read<ColorCatcherBloc>().updateBasket(newX);
                  },
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              // HUD
              Positioned(
                top: 40,
                left: 20,
                child: Text(
                  "Score: ${state.score}   Lives: ${state.lives}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Game Over
              if (state.isGameOver)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Game Over",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<ColorCatcherBloc>().startGame(),
                        child: const Text("Restart"),
                      )
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
