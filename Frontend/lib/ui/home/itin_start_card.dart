import 'package:flutter/material.dart';
import 'package:country_picker_plus/country_picker_plus.dart';

class ItinStartCard extends StatefulWidget {
  final void Function(String city, DateTimeRange dates) onSubmit;
  final VoidCallback onClose;

  const ItinStartCard({super.key, required this.onSubmit, required this.onClose});

  @override
  State<ItinStartCard> createState() => _ItinStartCardState();
}

class _ItinStartCardState extends State<ItinStartCard> {
  String? _selectedCity;
  DateTimeRange? _selectedDates;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 40), // space from top
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(16.0), // reduced padding
            child: SizedBox(
              width: screenWidth < 450 ? screenWidth * 0.9 : 400, // responsive width
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: widget.onClose,
                        ),
                      ],
                    ),
                    const Text(
                      'Start Your Itinerary',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    CountryPickerPlus(
                      isRequired: true,
                      countryLabel: "Country",
                      countrySearchHintText: "Search Country",
                      countryHintText: "Tap to Select Country",
                      cityLabel: "City",
                      cityHintText: "Tap to Select City",
                      onCitySelected: (value) {
                        setState(() {
                          _selectedCity = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        _selectedDates == null
                            ? 'Select your dates'
                            : '${_selectedDates!.start.toLocal().toString().split(' ')[0]} - ${_selectedDates!.end.toLocal().toString().split(' ')[0]}',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final now = DateTime.now();
                        final picked = await showDateRangePicker(
                          context: context,
                          firstDate: now,
                          lastDate: DateTime(now.year + 2),
                          initialDateRange: _selectedDates,
                        );
                        if (picked != null) {
                          setState(() => _selectedDates = picked);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: (_selectedCity != null && _selectedDates != null)
                          ? () => widget.onSubmit(_selectedCity!, _selectedDates!)
                          : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Start Planning'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}