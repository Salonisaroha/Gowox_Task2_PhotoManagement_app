import 'package:flutter/material.dart';
import 'add_photo_screen.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, List<String>> _albums = {
    'Posters': [],
    'Family': [],
    'Flowers': [],
    'Animals': [],
  };

  Map<String, String> _categoryImages = {
    'Posters': 'assets/images/poster.png',
    'Family': 'assets/images/family.png',
    'Flowers': 'assets/images/flowers.png',
    'Animals': 'assets/images/animals.png',
  };

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _addPhoto(Map<String, dynamic> data) {
    setState(() {
      String path = data['path'];
      String category = data['category'];
      _albums[category]!.add(path);
    });
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _handleProfile() {
    // Implement profile functionality
    print('Profile');
  }

  void _navigateToCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryScreen(
          category: category,
          photos: _albums[category]!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> _filteredCategories = _albums.keys
        .where((category) => category.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 5,
        centerTitle: true,
        title: const Text(
          'Photo Management App',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                Navigator.pop(context);
                _handleSearch(_searchController.text);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                _handleProfile();
              },
            ),
            Divider(),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Implement logout functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My Profile'),
              onTap: () {
                // Implement my profile functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Joined'),
              onTap: () {
                // Implement joined functionality
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 224, 229, 232), Color.fromARGB(255, 186, 223, 240)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search categories...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _handleSearch,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: _filteredCategories.map((category) {
                  return GestureDetector(
                    onTap: () => _navigateToCategory(category),
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              _categoryImages[category]!,
                              height: 100,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            category,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPhotoScreen()),
          );
          if (result != null) {
            _addPhoto(result);
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          if (index == 1) {
            _handleSearch(_searchController.text);
          } else if (index == 2) {
            _handleProfile();
          }
        },
      ),
    );
  }
}
