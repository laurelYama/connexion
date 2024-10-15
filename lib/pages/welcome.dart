import 'package:flutter/material.dart';

import 'LoginPage.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: VacationCarousel(),
      ),
    );
  }
}

class VacationCarousel extends StatefulWidget {
  @override
  _VacationCarouselState createState() => _VacationCarouselState();
}

class _VacationCarouselState extends State<VacationCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final List<String> images = [
    'https://th.bing.com/th/id/OIP.gasnF5fn6gCba6oDH5ryagHaHI?rs=1&pid=ImgDetMain', // Image 1
    'https://th.bing.com/th/id/OIP.hrjwwALt_Re66O-AYwTGXQHaEo?rs=1&pid=ImgDetMain', // Image 2
    'https://th.bing.com/th/id/OIP.qlcZkymGfCwngpzh4wvc7gHaHa?w=736&h=736&rs=1&pid=ImgDetMain', // Image 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Carrousel d'images
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.error, color: Colors.red, size: 40),
                    ),
                  );
                },
              );
            },
          ),

          // Conteneur blanc fixe qui chevauche légèrement l'image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.5, // Hauteur du conteneur augmentée
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), // Bord supérieur droit arrondi
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '0${_currentIndex + 1}.03',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Let's find your\n dream vacation",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Hotels, Resorts, Hostels & more get the\n best prices on 2,000,000+ properties,\n worldwide',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Barre de progression dynamique
                      Row(
                        children: List.generate(images.length, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            width: _currentIndex == index ? 50 : 30,
                            height: 5,
                            decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? const Color(0xFF018868)
                                  : Colors.grey,
                              borderRadius: BorderRadius.zero,
                            ),
                          );
                        }),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Redirection vers la page SignIn
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF018868), // Couleur de fond
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Bords carrés
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Get started',
                              style: TextStyle(
                                  color: Colors.white), // Texte en blanc
                            ),
                            Icon(Icons.arrow_forward,
                                color: Colors.white), // Icône en blanc
                          ],
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
    );
  }
}
