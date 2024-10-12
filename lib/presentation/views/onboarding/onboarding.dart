import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_app/data/share_prefs/prefs_usuario.dart';
import 'package:pet_app/data/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  OnbordingState createState() => OnbordingState();
}

class OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<UnbordingContent> contents = [
    UnbordingContent(
        title: 'Añade animales perdidos',
        image: 'assets/backs/form1.png',
        discription:
            "¿Te encontraste un animal perdido, un animal en peligro o una mascota en riesgo? Vas por la calle y ves un animal en peligro. Subelo rápidamente y ayuda a que reciba el mejor trato o a que la gente encuentre a su mascota perdida."),
    UnbordingContent(
        title: 'Busca tu veterinaria',
        image: 'assets/backs/form2.png',
        discription: "¿No sabes donde hay una veterinaria cerca? "
            "Encuentra veterinarias cerca de ti, conoce cuales atienden 24 horas y añade tus reseñas."),
    UnbordingContent(
        title: '¿Tienes un refugio?',
        image: 'assets/backs/form1.png',
        discription: "Agrega tu refugio para que más personas lo encuentren. "
            "Añade tu información y ayuda a que la gente conozca más lugares para ayudar a los animales."),
    UnbordingContent(
        title: 'Busca lo mejor para tu mascota',
        image: 'assets/backs/form2.png',
        discription:
            "Encuentra en nuestra tienda en línea los mejores artículos para cuidar de tus mascotas."),
  ];

  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();

    return Scaffold(
      floatingActionButton: Bounceable(
        onTap: () {
          if (currentIndex == contents.length - 1) {
            context.pushNamed('login');
            prefs.show_onboarding = false;
          }
          _controller.nextPage(
            duration: const Duration(milliseconds: 100),
            curve: Curves.bounceIn,
          );
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: ColorsStyle.primaryColor,
              borderRadius: BorderRadius.circular(20)),
          child: Icon(
            currentIndex == contents.length - 1
                ? Icons.arrow_outward_rounded
                : Icons.arrow_forward_ios_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 11,
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Stack(
                  children: [
                    (i == 0)
                        ? Positioned(
                            top: -50,
                            right: 200,
                            child: Image.asset("assets/backs/form1.png"))
                        : (i == 1)
                            ? Positioned(
                                top: -244,
                                left: 100,
                                child: Image.asset("assets/backs/form2.png"))
                            : Positioned(
                                top: -301,
                                right: 101,
                                child: Image.asset("assets/backs/form1.png")),
                    SizedBox(
                      width: double.infinity,
                      child: FadeAnimation(
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.pets_rounded,
                                  size: 150, color: ColorsStyle.primaryColor),
                              const SizedBox(height: 20),
                              Text(
                                contents[i].title,
                                textAlign: TextAlign.center,
                                style:
                                    TxtStyle.headerStyle.copyWith(height: 0.7),
                              ),
                              const SizedBox(height: 20),
                              Text(contents[i].discription,
                                  textAlign: TextAlign.center,
                                  style: TxtStyle.descriptionStyle
                                      .copyWith(fontSize: 7.f))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Bounceable(
      onTap: () {
        _controller.animateToPage(
          index,
          duration: const Duration(milliseconds: 100),
          curve: Curves.bounceIn,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 12,
        width: currentIndex == index ? 35 : 12,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorsStyle.primaryColor,
        ),
      ),
    );
  }
}

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}
