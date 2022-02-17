import 'package:flutter/material.dart';
import 'package:movie_cast_stacked/ui/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import './home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (HomeViewModel model) async {
        await model.init();
      },
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            body: FutureBuilder(
          future: model.getDirectors(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: screenHeight(context),
                color: Colors.yellow,
                child: GridView.builder(
                  itemCount: model.directorsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () =>
                        model.onTap(model.directorsList[index].documentId),
                    child: Card(
                      color: Colors.amber,
                      child: Center(
                        child: Text(model.directorsList[index].name,
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const IntroWidget();
            }
          },
        ));
      },
    );
  }
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).backgroundColor,
          width: screenWidth(context),
          height: screenHeight(context),
          child: CustomPaint(
            size: const Size(400, 400),
            painter: CurvedPainter(),
            child: CustomPaint(
              painter: CirclePainter(),
              // color: Colors.red,
            ),
            foregroundPainter: ArrowPainter(),
          ),
        ),
        Positioned(
          top: 200,
          left: screenWidthFraction(context, dividedBy: 4),
          child: Text(
            "Movie Cast",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;
    var path = Path();

    path.moveTo(size.width, 0);
    path.quadraticBezierTo(size.width * 0.90, size.height * 0.20,
        size.width * 0.62, size.height * 0.26);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.35,
        size.width * 0.4, size.height * 0.47);
    path.quadraticBezierTo(
        size.width * 0.6, size.height * 0.65, 0, size.height * 0.65);
    // path.quadraticBezierTo(size.width * 0.22, size.height * 0.68,
    // size.width * 0.28, size.height * 0.67);
    path.lineTo(0, size.height * 0.65);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    Offset center = Offset(size.width / 1.5, size.height / 2);

    canvas.drawCircle(center, 40, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
