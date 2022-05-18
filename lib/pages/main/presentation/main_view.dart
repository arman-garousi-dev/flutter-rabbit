import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rabbit/pages/main/business_logic/main_cubit.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              _buildRoadSlider(
                context,
                state,
                screenSize: screenSize,
              ),
              if (state.isPlaying) _buildRabbitImage(context),
              _buildDistanceContainer(context, state),
              if (!state.isPlaying)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildGameOverContainer(context),
                    const SizedBox(height: 16),
                    _buildRetryButton(context),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRoadSlider(
    BuildContext context,
    MainState state, {
    required Size screenSize,
  }) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: screenSize.height,
        viewportFraction: 1,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        reverse: true,
        pageSnapping: false,
        autoPlay: state.isMoving,
        autoPlayInterval: const Duration(milliseconds: 100),
        autoPlayAnimationDuration: const Duration(milliseconds: 100),
        autoPlayCurve: Curves.linear,
        pauseAutoPlayOnTouch: false,
      ),
      itemCount: double.maxFinite.toInt(),
      itemBuilder: (context, index, realIndex) => _buildRoadImage(
        context,
        screenSize: screenSize,
      ),
    );
  }

  Widget _buildRoadImage(BuildContext context, {required Size screenSize}) {
    return Image.asset(
      'assets/images/road.png',
      width: screenSize.width,
      height: screenSize.height,
      repeat: ImageRepeat.repeatY,
    );
  }

  Widget _buildRabbitImage(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        context.read<MainCubit>().move();
      },
      onTapUp: (details) {
        context.read<MainCubit>().stop();
      },
      child: Image.asset(
        'assets/images/rabbit.webp',
        width: 75,
        height: 75,
      ),
    );
  }

  Widget _buildDistanceContainer(BuildContext context, MainState state) {
    return Positioned(
      top: 16,
      right: 16,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28 / 2),
          color: Colors.white,
        ),
        width: 75,
        height: 28,
        alignment: Alignment.center,
        child: Text(state.distanceTimerNumber.toString()),
      ),
    );
  }

  Widget _buildGameOverContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32 / 2),
        color: Colors.red,
      ),
      width: 100,
      height: 32,
      alignment: Alignment.center,
      child: const Text(
        'Game Over',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRetryButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const CircleBorder(),
        ),
        fixedSize: MaterialStateProperty.all(
          const Size(50, 50),
        ),
        backgroundColor: MaterialStateProperty.all(
          Colors.green,
        ),
      ),
      onPressed: () {
        context.read<MainCubit>().retry();
      },
      child: const Icon(Icons.refresh_rounded),
    );
  }
}
