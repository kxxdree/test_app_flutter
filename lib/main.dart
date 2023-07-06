import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app_flutter/models/cities.dart';
import 'package:test_app_flutter/models/cities_streets.dart';

void main() => runApp(const CitiesApp());

class CitiesApp extends StatelessWidget {
  const CitiesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoadingPage(),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          child: const Image(
            image: AssetImage('assets/images/LoadingPage.png'),
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<CitiesList> citiesList;

  @override
  void initState() {
    super.initState();
    citiesList = getCitiesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Города',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<CitiesList>(
        future: citiesList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data?.cities.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StreetsScreen(),
                              ),
                            );
                          },
                          child: Image.network('${snapshot.data?.cities[index].image}'),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${snapshot.data?.cities[index].name}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${snapshot.data?.cities[index].totalPeople} человек',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text('Широта ${snapshot.data?.cities[index].lat}°'),
                        Text('Долгота ${snapshot.data?.cities[index].long}°'),
                        const SizedBox(height: 8),
                        Text('Фото сделано ${snapshot.data?.cities[index].dateTimeImage}'),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ErrorScreen(),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EmptyScreen(),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class StreetsScreen extends StatefulWidget {
  const StreetsScreen({super.key});

  @override
  State<StreetsScreen> createState() => _StreetsScreenState();
}

class _StreetsScreenState extends State<StreetsScreen> {
  late Future<StreetsList> streetsList;
  String? cityId;

  @override
  void initState() {
    super.initState();
    streetsList = getStreetList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Улицы города',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<StreetsList>(
          future: streetsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.streets.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        '${snapshot.data?.streets[index].name}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        '${snapshot.data?.streets[index].address}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmptyScreen(),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Image(
              image: AssetImage('assets/images/ErrorScreen.png'),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Попробовать снова'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Image(
              image: AssetImage('assets/images/EmptyScreen.png'),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Вернуться назад',
                    style: TextStyle(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
