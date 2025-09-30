import 'package:flutter/material.dart';

void main() {
  runApp(const FarmersApp());
}

class FarmersApp extends StatelessWidget {
  const FarmersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmers Helper',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  // Pages for the bottom navigation
  static final List<Widget> _pages = <Widget>[
    const DashboardPage(),
    const MarketPage(),
    const WeatherPage(),
    const TipsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmers Helper'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          )
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Quick action example (e.g. add field note, call extension, etc.)
          showModalBottomSheet(
            context: context,
            builder: (_) => SizedBox(
              height: 160,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.note_add),
                    title: const Text('Add Field Note'),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Open: Add Field Note')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    title: const Text('Contact Expert'),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Calling agricultural expert...')),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        tooltip: 'Quick actions',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ---------------------- Example Pages ----------------------

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Welcome, Farmer!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Today\'s quick summary:'),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.thermostat),
              title: const Text('Temperature'),
              subtitle: const Text('22°C • Mild'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.water_drop),
              title: const Text('Soil Moisture'),
              subtitle: const Text('Optimal'),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Recent tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: const [
                ListTile(leading: Icon(Icons.check_circle_outline), title: Text('Irrigate maize field A')), 
                ListTile(leading: Icon(Icons.check_circle_outline), title: Text('Fertilizer delivery scheduled')), 
                ListTile(leading: Icon(Icons.check_circle_outline), title: Text('Check pest traps')),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MarketPage extends StatelessWidget {
  const MarketPage({Key? key}) : super(key: key);

  // In a real app, this would fetch prices from a backend or API.
  @override
  Widget build(BuildContext context) {
    final samplePrices = {
      'Maize (90kg)': 'KES 4,500',
      'Tomatoes (crate)': 'KES 1,200',
      'Onions (crate)': 'KES 1,000',
    };

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Text('Local Market Prices', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: samplePrices.length,
              itemBuilder: (context, index) {
                final key = samplePrices.keys.elementAt(index);
                final value = samplePrices[key];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.shopping_basket),
                    title: Text(key),
                    trailing: Text(value ?? ''),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  // In a production app, integrate a weather API and show detailed forecast.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.cloud, size: 64),
            SizedBox(height: 12),
            Text('Nairobi — 22°C', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('Light showers expected in the afternoon.'),
          ],
        ),
      ),
    );
  }
}

class TipsPage extends StatelessWidget {
  const TipsPage({Key? key}) : super(key: key);

  final List<String> _tips = const [
    'Rotate crops every season to keep soil healthy.',
    'Use mulch to retain soil moisture and suppress weeds.',
    'Inspect crops weekly for early signs of pests.',
    'Keep records of fertilizer and pesticide usage.',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: _tips.length,
      itemBuilder: (context, i) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.local_florist),
            title: Text(_tips[i]),
          ),
        );
      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace with actual user/profile management
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const CircleAvatar(radius: 42, child: Icon(Icons.person, size: 48)),
          const SizedBox(height: 12),
          const Text('Patience Wangui', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Farm: Green Valley • Location: Kiambu'),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Open settings...')));
            },
            icon: const Icon(Icons.settings),
            label: const Text('Settings'),
          )
        ],
      ),
    );
  }
}
