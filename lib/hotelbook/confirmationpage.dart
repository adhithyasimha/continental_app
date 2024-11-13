import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final String hotelName;
  final String roomType;

  const ConfirmationPage({
    Key? key,
    required this.hotelName,
    required this.roomType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmed'),
        backgroundColor: Color(0xFF1E1E1E),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(Icons.check_circle_outline,
                  color: Colors.green, size: 100),
            ),
            SizedBox(height: 24),
            Center(
              child: Text(
                'Thank You for Your Reservation!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Hotel: $hotelName',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]),
            ),
            Text(
              'Room Type: $roomType',
              style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Text(
              'Reservation Details',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            // Other booking details here, like check-in, check-out dates, and guests.
          ],
        ),
      ),
    );
  }
}
