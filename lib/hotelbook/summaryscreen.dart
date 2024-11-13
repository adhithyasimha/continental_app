import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FinalScreen extends StatefulWidget {
  final String hotelName;
  final String roomType;
  final String description;
  final double price;
  final List<String> features;
  final String imagePath;
  final DateTime checkInDate;
  final DateTime checkOutDate;

  const FinalScreen({
    Key? key,
    required this.hotelName,
    required this.roomType,
    required this.description,
    required this.price,
    required this.features,
    required this.imagePath,
    required this.checkInDate,
    required this.checkOutDate,
  }) : super(key: key);

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  final _formKey = GlobalKey<FormState>();
  final SupabaseClient supabase = SupabaseClient(
    'https://cdoayrodwkfjfinjpqwk.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNkb2F5cm9kd2tmamZpbmpwcXdrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjgzMTc0NDEsImV4cCI6MjA0Mzg5MzQ0MX0.dIN2vypn7amiEv1T8qQH-WZII8b2cD296gXvVWogqss', // Replace with your actual Supabase anon key
  );
  String _guestName = '';
  int _numberOfGuests = 1;
  String _nationality = '';
  late DateTime _checkInDate;
  late DateTime _checkOutDate;

  @override
  void initState() {
    super.initState();
    _checkInDate = widget.checkInDate;
    _checkOutDate = widget.checkOutDate;
  }

  Future<void> _submitBooking() async {
    final response = await supabase.from('rev').insert({
      'check_in_date': _checkInDate.toIso8601String(),
      'check_out_date': _checkOutDate.toIso8601String(),
      'guest_name': _guestName,
      'guest_nationality': _nationality,
      'room_type': widget.roomType,
      'number_of_guests': _numberOfGuests,
      'total_price': widget.price,
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationPage(
          hotelName: widget.hotelName,
          roomType: widget.roomType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Booking Summary'),
        backgroundColor: Color(0xFF1E1E1E),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Room Image
              Container(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),

              // Room Details
              Text(
                widget.roomType,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.description,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),

              // Features
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.features
                    .map((feature) => Chip(
                          label: Text(
                            feature,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Color(0xFF1E1E1E),
                        ))
                    .toList(),
              ),
              SizedBox(height: 24),

              // Check-in and Check-out Dates
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, true),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Check-in Date',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text(
                          '${_checkInDate.toLocal()}'.split(' ')[0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, false),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Check-out Date',
                          labelStyle: TextStyle(color: Colors.grey[400]),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text(
                          '${_checkOutDate.toLocal()}'.split(' ')[0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Guest Information Form
              Card(
                color: Color(0xFF2C2C2C),
                child: ExpansionTile(
                  title: Text(
                    'Guest Information',
                    style: TextStyle(color: Colors.white),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Guest Name',
                                labelStyle: TextStyle(color: Colors.grey[400]),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter guest name';
                                }
                                return null;
                              },
                              onSaved: (value) => _guestName = value!,
                            ),
                            SizedBox(height: 16),
                            DropdownButtonFormField<int>(
                              decoration: InputDecoration(
                                labelText: 'Number of Guests',
                                labelStyle: TextStyle(color: Colors.grey[400]),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              dropdownColor: Color(0xFF2C2C2C),
                              value: _numberOfGuests,
                              items: [1, 2, 3, 4].map((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(
                                    value.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (int? value) {
                                setState(() {
                                  _numberOfGuests = value!;
                                });
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nationality',
                                labelStyle: TextStyle(color: Colors.grey[400]),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter nationality';
                                }
                                return null;
                              },
                              onSaved: (value) => _nationality = value!,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Price Summary
              Card(
                color: Color(0xFF2C2C2C),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Room Rate',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          Text(
                            '\$${widget.price.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      // Add more price details as needed
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Book Now Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _submitBooking();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Confirm Booking',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E1E1E),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime picked = await showDatePicker(
          context: context,
          initialDate: isCheckIn ? _checkInDate : _checkOutDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2101),
        ) ??
        DateTime.now();

    setState(() {
      if (isCheckIn) {
        _checkInDate = picked;
      } else {
        _checkOutDate = picked;
      }
    });
  }
}

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
        title: Text('Booking Confirmation'),
        backgroundColor: Color(0xFF1E1E1E),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Booking Confirmed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Hotel: $hotelName',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Room Type: $roomType',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Text(
                  'Go Back',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
