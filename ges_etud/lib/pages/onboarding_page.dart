import 'package:flutter/material.dart';
import 'package:ges_etud/aimation/delayed_animtion.dart';
import 'package:ges_etud/main.dart';
import 'package:ges_etud/pages/home_page.dart';
import 'package:ges_etud/pages/login/login_page.dart';
import 'package:ges_etud/widgets/onboarding.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Color bg = d_blue;

  @override
  Widget build(BuildContext context) {
    if (_currentPage == 0) {
      bg = Color(0XFF1A2B6D);
    } else if (_currentPage == 1) {
      Color(0XFF1B3A7A);
    } else {
      bg = Color(0XFF0F2357);
    }
    return Scaffold(
      backgroundColor: bg,
      // appBar: AppBar(toolbarHeight: 80, backgroundColor: d_blue)
      body: Stack(
        alignment: AlignmentGeometry.bottomCenter,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              OnBoarding(
                icon: Icons.school_rounded,
                subtitle: "Bienvenue",
                title: "Gestion Étudiants",
                description:
                    "Votre outil de gestion académique complet. Centralisez toutes les fiches étudiants en un seul endroit.",
              ),
              OnBoarding(
                icon: Icons.person_2_rounded,
                subtitle: "Suivi complet",
                title: "Gérez chaque fiches",
                description:
                    "Ajoutez, modifiez ou supprimez une fiche étudiant en quelques secondes. Filtrez par promotion, filière ou statut.",
              ),
              OnBoarding(
                icon: Icons.cloud_upload_rounded,
                subtitle: "Syncronisation",
                title: "Sync en temps réel",
                description:
                    "Vos données sont synchronisées instantanément avec le serveur. Accédez aux informations depuis n'importe quel appareil",
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DelayedAnimation(
                  delay: 1500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: Duration(microseconds: 300),
                        margin: EdgeInsets.only(right: 5),
                        height: 10,
                        width: _currentPage == index ? 30 : 10,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                DelayedAnimation(
                  delay: 2000,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_currentPage < 2) {
                          // _pageController.previousPage(duration: duration, curve: curve)
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        _currentPage < 2 ? "Suivant" : "Commencer",
                        style: TextStyle(
                          color: d_blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                DelayedAnimation(
                  delay: 2500,
                  child: TextButton(
                    onPressed: () {
                      if (_currentPage < 2) {
                        // _pageController.previousPage(duration: duration, curve: curve)
                        _pageController.jumpToPage(2);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      }
                    },
                    child: Text(
                      _currentPage == 2 ? "Connexion" : "Passer l'intro",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
