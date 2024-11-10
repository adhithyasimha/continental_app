import 'package:flutter/material.dart';
import './roomselection.dart';

class HotelDetailsScreen extends StatelessWidget {
  final String hotelName;
  final String location;
  final double rating;
  final int reviews;
  final String phoneNumber;
  final List<String> amenities;
  final double price;

  const HotelDetailsScreen({
    Key? key,
    required this.hotelName,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.phoneNumber,
    required this.amenities,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Gallery Section
                Container(
                  height: 300,
                  child: PageView(
                    children: [
                      Image.asset(
                        'assets/caesar1.png',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/caesar2.png',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/caesar3.png',
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                // Top Bar
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.share, color: Colors.white),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite_border,
                                  color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '$rating ($reviews Reviews)',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.grey[600], size: 20),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _buildExploreCard('Dining', Icons.restaurant),
                      _buildExploreCard('Fitness', Icons.fitness_center),
                      _buildExploreCard('Spa', Icons.spa),
                      _buildExploreCard('Attractions', Icons.attractions),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Amenities',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: amenities
                        .map((amenity) => _buildAmenityChip(amenity))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FROM',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '\$${price.toStringAsFixed(2)}/Night',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomSelectionScreen(
                      hotelName: "Caesar's Palace",
                      basePrice: price,
                    ),
                  ),
                );
              },
              child: Text('Select Room'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreCard(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityChip(String amenity) {
    return Chip(
      label: Text(amenity),
      backgroundColor: const Color.fromARGB(255, 55, 53, 53),
    );
  }
}
