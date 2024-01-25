import 'package:flutter/material.dart';
import 'package:showtime/Config/configColor.dart';
import 'package:showtime/Config/configText.dart';
import 'package:showtime/Config/sectionTitle.dart';
import 'package:showtime/Models/movieCategories.dart';
import 'package:showtime/Models/movieData.dart';
import 'package:showtime/Views/playMovie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showtime/Widgets/movieCategory.dart';
import 'package:showtime/Widgets/movieGenres.dart';
import 'package:showtime/Widgets/relatedMovies.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MovieData movieData = MovieData();
  MovieCategory movieCategory = MovieCategory();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      // drawer: const ProfileDrawer(),
      extendBody: true,
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: ConfigColor.white,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home_filled),
            title: Text("Home"),
            selectedColor: ConfigColor.secondary,
            unselectedColor: ConfigColor.white,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("Likes"),
            selectedColor: ConfigColor.secondary,
            unselectedColor: ConfigColor.white,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.public),
            title: Text("Discover"),
            selectedColor: ConfigColor.secondary,
            unselectedColor: ConfigColor.white,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: ConfigColor.secondary,
            unselectedColor: ConfigColor.white,
          ),
        ],
        backgroundColor: Colors.black.withOpacity(0.2),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
              ConfigColor.primary,
              ConfigColor.primary,
              ConfigColor.lightPrimary,
            ])),
        child: SafeArea(
            child: ListView(
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/13033815/pexels-photo-13033815.jpeg'),
              ),
              title: Text(
                'Welcome back,',
                style:
                    GoogleFonts.poppins(color: ConfigColor.white, fontSize: 13),
              ),
              subtitle: Text(
                'Claire Dupont',
                style: GoogleFonts.poppins(
                    color: ConfigColor.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              trailing: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 28,
                    color: ConfigColor.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  FaIcon(
                    FontAwesomeIcons.search,
                    color: ConfigColor.white,
                    size: 22,
                  ),
                ],
              ),
            ),
            ListTile(
              title: const SectionTitle(
                title: 'Trending Movies🍿',
              ),
              trailing: Text(
                'See all',
                style: GoogleFonts.poppins(
                    color: ConfigColor.secondary, fontSize: 14),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PlayMovie()));
              },
              child: RelatedMovies(
                relatedMovieImage: movieData.relatedMovieImage,
                carouselHeight: 200,
                autoplay: true,
                playButton: 20,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: SectionTitle(
                title: 'Categories',
              ),
            ),
            SizedBox(
              height: 30,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return MovieCategories(
                    categoryName: movieCategory.categories[index],
                  );
                },
                itemCount: movieCategory.categories.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SectionTitle(
                title: 'Genres',
              ),
            ),
            MovieGenres(movieData: movieData),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SectionTitle(
                title: 'New Movies🍿',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: BannerCarousel(
                borderRadius: 0,
                activeColor: ConfigColor.secondary,
                viewportFraction: 0.50,
                height: size.height * 0.29,
                width: size.width,
                banners: movieData.newMovies,
                initialPage: 1,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
