import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/model.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<Details> {
  String? number = '01226474010';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TimeOfDay? numberOfHours = const TimeOfDay(hour: 1, minute: 0);

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final TimeOfDay pickedHour = TimeOfDay(hour: picked.hour, minute: 0);
      setState(() => selectedTime = pickedHour);
    }
  }

  Future<void> _selectHour() async {
    int selectedHour = const TimeOfDay(hour: 1, minute: 0).hour;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Hour"),
          content: SizedBox(
            height: 200,
            child: ListWheelScrollView.useDelegate(
              itemExtent: 40,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                selectedHour = index + 1;
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  return Center(
                    child: Text(
                      "${index + 1}:00",
                      style: const TextStyle(fontSize: 22),
                    ),
                  );
                },
                childCount: 24,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() =>
                    numberOfHours = TimeOfDay(hour: selectedHour, minute: 0));
                Navigator.pop(context);
              },
              child: const Text("Done"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Model? model = ModalRoute.of(context)!.settings.arguments as Model?;
    var price = int.parse(model!.price) *
        (numberOfHours != null ? numberOfHours!.hour : 1);

    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            model.image,
            width: double.infinity,
            height: 350,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    model.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      model.location,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _selectDate,
                      child: const Text('Date'),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Date: ${selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : ''}',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _selectTime,
                      child: const Text('Time'),
                    ),
                    const SizedBox(width: 16),
                    Text(
                        'Time: ${selectedTime != null ? selectedTime!.format(context) : ''}'),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _selectHour,
                      child: const Text('Hour'),
                    ),
                    const SizedBox(width: 16),
                    Text(
                        'Hour: ${numberOfHours != null ? numberOfHours!.hour.toString() : ''}'),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price: $price EGP',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Show a confirmation dialog
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: Text(
                                        'Confirm Booking',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Date: ${selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : ''}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Time: ${selectedTime != null ? selectedTime!.format(context) : ''}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Hour: ${numberOfHours != null ? numberOfHours!.hour.toString() : ''}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Price: $price EGP',
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'assets/images/whatsapp.png',
                                          width: 35,
                                          height: 35,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _whatsApp(number, price);
                                          },
                                          child: const Text('WhatsApp'),
                                        ),
                                        const SizedBox(height: 8),
                                        Image.asset(
                                          'assets/images/phone.png',
                                          width: 35,
                                          height: 35,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _call(number);
                                          },
                                          child: const Text('Call'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              );
                            });
                      },
                      child: const Text('Book Now'),
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

  void _whatsApp(number, price) async {
    await launchUrlString(
        'https://wa.me/$number?text=Hello,\ni\'m coming from App Football Finder to book a playground \nDate: ${selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : ''} \nTime: ${selectedTime != null ? selectedTime!.format(context) : ''} \nHour: ${numberOfHours != null ? numberOfHours!.hour.toString() : ''} \nPrice: $price EGP',
        mode: LaunchMode.externalApplication);
  }

  void _call(number) async {
    var url = 'tel:$number';
    await launchUrl(Uri.parse(url));
  }
}
