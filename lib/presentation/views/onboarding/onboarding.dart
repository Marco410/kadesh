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
        title: 'Reporta animales en peligro',
        image: 'assets/backs/form1.png',
        imageBack: 'labrador.jpg',
        icon: "dog-cat.png",
        discription:
            "¿Viste un animal perdido o en peligro? Si vas por la calle y encuentras una mascota extraviada o un animal en riesgo, ¡repórtalo al instante! Súbelo a Kadesh y ayúdanos a que reciba atención, protección y, si es posible, vuelva a casa."),
    UnbordingContent(
        title: 'Busca tu veterinaria',
        image: 'assets/backs/form2.png',
        icon: "pet-store.png",
        imageBack: 'gato-naranja.jpg',
        discription: "¿No sabes dónde hay una veterinaria cerca? "
            "Encuentra las más cercanas, conoce cuáles están disponibles las 24 horas y comparte tu experiencia con reseñas para ayudar a otros."),
    UnbordingContent(
        title: '¿Tienes un refugio?',
        image: 'assets/backs/form1.png',
        imageBack: 'bunny.jpg',
        icon: "doghouse.png",
        discription: "¿Tienes un refugio? ¡Haz que más personas lo conozcan! "
            "Agrega tu información y permite que quienes quieren ayudar encuentren tu refugio más fácilmente. Juntos podemos salvar más vidas."),
    UnbordingContent(
        title: 'Estatus de rescate en tiempo real',
        image: 'assets/backs/form2.png',
        imageBack: 'parrot.jpg',
        icon: "animal-care.png",
        discription: "Del abandono al amor."
            "Mira el progreso de cada rescate: en calle, rescatado, curando, adoptado o en familia."),

    /* UnbordingContent(
        title: 'Busca lo mejor para tu mascota',
        image: 'assets/backs/form2.png',
        imageBack: 'parrot.jpg',
        discription:
            "Encuentra en nuestra tienda en línea los mejores artículos para cuidar de tus mascotas."), */
  ];

  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: SizedBox.expand(
              key: ValueKey<String>(contents[currentIndex].imageBack),
              child: Image.asset(
                'assets/images/${contents[currentIndex].imageBack}',
                opacity: const AlwaysStoppedAnimation(0.6),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
                  color: ColorStyle.primaryColor,
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
                                top: -150,
                                right: 220,
                                child: Image.asset("assets/backs/form1.png"))
                            : (i == 1)
                                ? Positioned(
                                    top: -325,
                                    left: 100,
                                    child:
                                        Image.asset("assets/backs/form2.png"))
                                : (i == 2)
                                    ? Positioned(
                                        top: -350,
                                        right: 101,
                                        child: Image.asset(
                                            "assets/backs/form1.png"))
                                    : Positioned(
                                        bottom: -150,
                                        left: 240,
                                        child: Image.asset(
                                            "assets/backs/form2.png")),
                        SizedBox(
                          width: double.infinity,
                          child: FadeAnimation(
                            child: Padding(
                              padding: const EdgeInsets.all(50),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ImageIcon(
                                      AssetImage(
                                          "assets/icons/${contents[i].icon}"),
                                      size: 120,
                                      color: ColorStyle.primaryColor),
                                  const SizedBox(height: 20),
                                  Text(
                                    contents[i].title,
                                    textAlign: TextAlign.center,
                                    style: TxtStyle.headerStyle.copyWith(
                                        height: 0.7, color: ColorStyle.white),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(contents[i].discription,
                                      textAlign: TextAlign.center,
                                      style: TxtStyle.descriptionStyle.copyWith(
                                          fontSize: 8.f,
                                          color: ColorStyle.white))
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
        ),
      ],
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
          color: ColorStyle.primaryColor,
        ),
      ),
    );
  }
}

class UnbordingContent {
  String image;
  String imageBack;
  String icon;
  String title;
  String discription;

  UnbordingContent(
      {required this.image,
      required this.imageBack,
      required this.icon,
      required this.title,
      required this.discription});
}
