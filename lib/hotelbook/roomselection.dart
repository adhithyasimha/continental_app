import 'package:flutter/material.dart';

class RoomSelectionScreen extends StatefulWidget {
  final String hotelName;
  final double basePrice;

  const RoomSelectionScreen({
    Key? key,
    required this.hotelName,
    required this.basePrice,
  }) : super(key: key);

  @override
  _RoomSelectionScreenState createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null &&
        picked != (isCheckIn ? _checkInDate : _checkOutDate)) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Select Your Room'),
        backgroundColor: Color(0xFF1E1E1E),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDateField(
                        context,
                        'Check-in',
                        _checkInDate,
                        () => _selectDate(context, true),
                      ),
                      _buildDateField(
                        context,
                        'Check-out',
                        _checkOutDate,
                        () => _selectDate(context, false),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildRoomCard(
                    'Forum Classic Room',
                    'Two Queen Beds, Roman Decor',
                    widget.basePrice,
                    ['42" LED TV', 'Mini Bar', 'Safe Deposit Box'],
                    'assets/room1.png',
                  ),
                  _buildRoomCard(
                    'Palace Premium Room',
                    'King Bed, Strip View',
                    widget.basePrice * 1.3,
                    ['Strip View', 'Premium Amenities', 'Luxury Bedding'],
                    'assets/room2.png',
                  ),
                  _buildRoomCard(
                    'Augustus Club Suite',
                    'Luxury Suite, 1 King Bed',
                    widget.basePrice * 1.8,
                    ['VIP Check-in', 'Club Lounge Access', 'Butler Service'],
                    'assets/room3.png',
                  ),
                  _buildRoomCard(
                    'Octavius Premium Suite',
                    'Luxury Corner Suite, Strip View',
                    widget.basePrice * 2.2,
                    ['Separate Living Area', 'Whirlpool Tub', 'Premium View'],
                    'assets/caesar3.png',
                  ),
                  _buildRoomCard(
                    'Imperial Villa',
                    'Ultimate Luxury Experience',
                    widget.basePrice * 3.5,
                    ['Private Pool', 'Piano Room', '24/7 Butler Service'],
                    'assets/room5.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(
      BuildContext context, String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              date != null ? '${date.toLocal()}'.split(' ')[0] : 'Select Date',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(
    String roomType,
    String description,
    double price,
    List<String> features,
    String imagePath,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      color: Color(0xFF2C2C2C),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomType,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: features
                      .map((feature) => Chip(
                            label: Text(
                              feature,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Color(0xFF1E1E1E),
                          ))
                      .toList(),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FROM',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                        Text(
                          '\$${price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 233, 229, 229),
                          ),
                        ),
                        Text(
                          'per night',
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Select'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 81, 80, 80),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}