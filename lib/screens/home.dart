import 'package:flutter/material.dart';

import '../models/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool isCardView = true;
  final List<Model> model = [
    Model(
      name: 'playground 1',
      location: 'Zayed',
      image: 'assets/images/img1.jpeg',
      price: '250',
    ),
    Model(
      name: 'playground 2',
      location: 'New Giza',
      image: 'assets/images/img2.jpg',
      price: '300',
    ),
    Model(
      name: 'playground 3',
      location: 'October',
      image: 'assets/images/img3.jpg',
      price: '350',
    ),
    Model(
      name: 'playground 1',
      location: 'Zayed',
      image: 'assets/images/img1.jpeg',
      price: '250',
    ),
    Model(
      name: 'playground 2',
      location: 'New Giza',
      image: 'assets/images/img2.jpg',
      price: '300',
    ),
    Model(
      name: 'playground 3',
      location: 'October',
      image: 'assets/images/img3.jpg',
      price: '350',
    ),
    Model(
      name: 'playground 1',
      location: 'Zayed',
      image: 'assets/images/img1.jpeg',
      price: '250',
    ),
    Model(
      name: 'playground 2',
      location: 'New Giza',
      image: 'assets/images/img2.jpg',
      price: '300',
    ),
    Model(
      name: 'playground 3',
      location: 'October',
      image: 'assets/images/img3.jpg',
      price: '350',
    ),
    Model(
      name: 'playground 1',
      location: 'Zayed',
      image: 'assets/images/img1.jpeg',
      price: '250',
    ),
    Model(
      name: 'playground 2',
      location: 'New Giza',
      image: 'assets/images/img2.jpg',
      price: '300',
    ),
    Model(
      name: 'playground 3',
      location: 'October',
      image: 'assets/images/img3.jpg',
      price: '350',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Finder'),
        actions: [
          IconButton(
            icon: Icon(
              isCardView ? Icons.grid_view : Icons.list,
              color: isCardView ? Colors.black : Colors.black54,
            ),
            onPressed: () {
              setState(() {
                isCardView = !isCardView;
              });
            },
          )
        ],
      ),
      body: isCardView ? _buildCardView() : _buildContainerView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/random');
          }
          if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'Random Team',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // view for card view
  Widget _buildCardView() {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (context, index) => Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () =>
              Navigator.pushNamed(context, '/details', arguments: model[index]),
          child: Column(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.asset(
                  model[index].image,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text(
                  model[index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      model[index].location,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                trailing: Text(
                  '${model[index].price} EGP',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // view for container view
  Widget _buildContainerView() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: model.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: InkWell(
          onTap: () =>
              Navigator.pushNamed(context, '/details', arguments: model[index]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    model[index].image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          model[index].location,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${model[index].price} EGP',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
