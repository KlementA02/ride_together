import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AVAILABLE RIDES'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {}, // Link to Profile later
          ),
        ],
      ),
      body: Stack(
        children: [
          // The Map Layer
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(5.6037, -0.1870), // Default to Accra coordinates
              zoom: 13,
            ),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          
          // Bottom Sheet Style Ride List (Swiss Style)
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.1,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  itemCount: 5,
                  separatorBuilder: (context, index) => const Divider(color: Colors.black),
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'ACCRA → KUMASI',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                      ),
                      subtitle: Text('DEPARTS: 14:00 • 3 SEATS LEFT'),
                      trailing: Text(
                        'GH₵ 150',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, // Navigate to "Offer Ride"
        label: const Text('OFFER A RIDE'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}