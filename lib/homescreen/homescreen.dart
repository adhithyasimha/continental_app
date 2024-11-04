import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.grey[850],
      colorScheme: ColorScheme.dark(
        primary: Colors.grey[850]!,
        secondary: Colors.grey[700]!,
      ),
    ),
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading delay
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return HomeContent(isLoading: _isLoading);
      case 1:
        return Center(
            child: Text('Book Screen', style: TextStyle(color: Colors.white)));
      case 2:
        return Center(
            child: Text('Trips Screen', style: TextStyle(color: Colors.white)));
      case 3:
        return Center(
            child:
                Text('Account Screen', style: TextStyle(color: Colors.white)));
      default:
        return HomeContent(isLoading: _isLoading);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            _buildBody(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Book'),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_travel), label: 'Trips'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.grey[850],
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final bool isLoading;

  const HomeContent({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Logo Section
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Image.asset(
              'assets/logo.png',
              height: 80,
            ),
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search Continental Services...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                fillColor: Colors.grey[900],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Recommendations Section
          SectionTitle('Recommended Stays'),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                if (isLoading) {
                  return SkeletonCard(width: 160);
                }
                return RecommendationCard(index: index);
              },
            ),
          ),

          // Destinations Section
          SectionTitle('Premium Destinations'),
          Container(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              itemBuilder: (context, index) {
                if (isLoading) {
                  return SkeletonCard(width: 140);
                }
                return DestinationCard(index: index);
              },
            ),
          ),

          // Dine & Earn Section
          SectionTitle('Dine & Earn'),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                if (isLoading)
                  SkeletonCard(width: double.infinity, height: 120)
                else
                  DineCard(
                    title: 'Continental Fine Dining',
                    description: 'Experience luxury dining and earn 2X points',
                    image: 'assets/dining.png',
                  ),
              ],
            ),
          ),

          // Explore Continental Section
          SectionTitle('Explore More with Continental'),
          Container(
            margin: EdgeInsets.all(16),
            height: 150,
            child: isLoading
                ? SkeletonCard(width: double.infinity)
                : ExploreCard(),
          ),
        ],
      ),
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final int index;

  const RecommendationCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.asset(
              'assets/hotel$index.png',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Continental ${index + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${200 + index * 50}/night',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final int index;

  const DestinationCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/destination$index.png',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Text(
              'Destination ${index + 1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.5),
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

class DineCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const DineCard({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ExploreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Explore Content',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class SkeletonCard extends StatelessWidget {
  final double width;
  final double? height;

  const SkeletonCard({
    Key? key,
    required this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 200,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-1.0, -0.5),
                end: Alignment(1.0, 0.5),
                colors: [
                  Colors.grey[900]!,
                  Colors.grey[800]!,
                  Colors.grey[900]!,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'View All',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
