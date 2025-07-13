import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kadesh/data/theme/style.dart';
import 'package:sizer_pro/sizer.dart';

class Home2Screen extends ConsumerStatefulWidget {
  const Home2Screen({super.key});

  @override
  ConsumerState<Home2Screen> createState() => _Home2ScreenState();
}

class _Home2ScreenState extends ConsumerState<Home2Screen> {
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  // Sample announcement data
  final List<Announcement> announcements = [
    Announcement(
      title: "¡Adopta una mascota!",
      description:
          "Encuentra tu compañero perfecto en nuestro refugio. Tenemos perros y gatos esperando un hogar amoroso.",
      image: "assets/images/labrador.jpg",
      date: "15 Dic 2024",
      category: "Adopción",
    ),
    Announcement(
      title: "Campaña de vacunación",
      description:
          "Vacunación gratuita para mascotas este sábado. Protege a tu compañero de enfermedades.",
      image: "assets/images/gato-naranja.jpg",
      date: "20 Dic 2024",
      category: "Salud",
    ),
    Announcement(
      title: "Taller de cuidado animal",
      description:
          "Aprende técnicas básicas de cuidado y primeros auxilios para mascotas.",
      image: "assets/images/bunny.jpg",
      date: "25 Dic 2024",
      category: "Educación",
    ),
    Announcement(
      title: "Donaciones necesarias",
      description:
          "Necesitamos comida, medicinas y materiales para ayudar a más animales.",
      image: "assets/images/parrot.jpg",
      date: "30 Dic 2024",
      category: "Donaciones",
    ),
  ];

  final CarouselSliderController controller = CarouselSliderController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Announcements Carousel
            Expanded(
              child: Column(
                children: [
                  // Section title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Anuncios",
                          style: TxtStyle.headerStyle.copyWith(
                            fontSize: 15.f,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Ver todos",
                              style: TxtStyle.labelStyle.copyWith(
                                color: KColors.primaryColor,
                              )),
                        ),
                      ],
                    ),
                  ),

                  CarouselSlider.builder(
                    itemCount: announcements.length,
                    carouselController: controller,
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Transform.scale(
                            scale: 1,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child:
                                  _buildAnnouncementCard(announcements[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Page indicators
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: announcements.asMap().entries.map((entry) {
                      return Bounceable(
                        onTap: () {
                          controller.animateToPage(entry.key.toInt(),
                              duration: const Duration(milliseconds: 500));
                        },
                        child: Container(
                          width: _currentPage == entry.key ? 40 : 15,
                          height: 5,
                          margin: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: _currentPage == entry.key
                                  ? KColors.primaryColor
                                  : KColors.hintColor),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(Announcement announcement) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Background image
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(announcement.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Category badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                    decoration: BoxDecoration(
                      color: KColors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      announcement.category,
                      style: TxtStyle.labelStyle.copyWith(
                        color: KColors.white,
                        fontSize: 8.f,
                      ),
                    ),
                  ),

                  // Title
                  Text(announcement.title,
                      style: TxtStyle.labelStyle.copyWith(
                        color: KColors.white,
                        fontSize: 13.f,
                      )),

                  // Description
                  Text(
                    announcement.description,
                    style: TxtStyle.labelStyle.copyWith(
                      color: KColors.hintLightColor,
                      fontSize: 8.f,
                      height: 0.8,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Date and action button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        announcement.date,
                        style: TxtStyle.labelStyle.copyWith(
                          color: KColors.hintColor,
                          fontSize: 8.f,
                        ),
                      ),
                      Bounceable(
                        onTap: () {
                          // Show announcement details
                          _showAnnouncementDetails(announcement);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          decoration: BoxDecoration(
                            color: KColors.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "Ver más",
                            style: TxtStyle.labelStyle.copyWith(
                              color: KColors.white,
                              fontSize: 8.f,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAnnouncementDetails(Announcement announcement) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(announcement.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Category and date
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              announcement.category,
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            announcement.date,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Title
                      Text(
                        announcement.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Description
                      Text(
                        announcement.description,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.grey[700],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[600],
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Participar",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Compartir",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Announcement {
  final String title;
  final String description;
  final String image;
  final String date;
  final String category;

  Announcement({
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.category,
  });
}
