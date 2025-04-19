import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon Application Flutter",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(title: "Page d'accueil Flutter"),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _genre = 'Homme'; 
  bool _codage = false; 
  bool _design = false; 
  bool _gaming = false; 
  DateTime _selectedDate = DateTime.now(); 
  double _competenceLevel = 1.0;
  String _formation = 'Informatique';
  bool _notifications = false; 

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker( 
      context: context, 
      initialDate: _selectedDate, 
      firstDate: DateTime(1900), 
      lastDate: DateTime.now(),
    ); 
    if (picked != null && picked != _selectedDate) { 
      setState(() { 
        _selectedDate = picked; 
      }); 
    } 
  }

  void _showProfile(BuildContext context) {
    // Récupération des informations
    String nom = _nomController.text;
    String age = _ageController.text;
    
    // Création du message 
    String message = 'Profil : $nom, $age ans, $_genre\n'; 
    message += 'Formation : $_formation\n'; 
    message += 'Date de naissance : ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}\n'; 
    message += 'Niveau : ${_competenceLevel.round()}/5\n'; 
    message += 'Intérêts : '; 
    if (_codage) message += 'Codage, '; 
    if (_design) message += 'Design, '; 
    if (_gaming) message += 'Jeux vidéo, '; 
    
    // Affichage du résultat 
    showDialog( 
      context: context, 
      builder: (context) => AlertDialog( 
        title: Text('Profil complet'), 
        content: Text(message), 
        actions: [ 
          TextButton( 
            onPressed: () => Navigator.pop(context), 
            child: Text('Fermer'), 
          ), 
        ], 
      ), 
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Entrez votre nom :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _nomController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Votre nom',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Entrez votre âge :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Votre âge',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text(
              'Genre :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Homme',
                  groupValue: _genre,
                  onChanged: (String? value) {
                    setState(() {
                      _genre = value!;
                    });
                  },
                ),
                Text('Homme'),
                SizedBox(width: 20),
                Radio<String>(
                  value: 'Femme',
                  groupValue: _genre,
                  onChanged: (String? value) {
                    setState(() {
                      _genre = value!;
                    });
                  },
                ),
                Text('Femme'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Centres d\'intérêt :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: Text('Codage'),
              value: _codage,
              onChanged: (bool? value) {
                setState(() {
                  _codage = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Design'),
              value: _design,
              onChanged: (bool? value) {
                setState(() {
                  _design = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Jeux vidéo'),
              value: _gaming,
              onChanged: (bool? value) {
                setState(() {
                  _gaming = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(height: 16),
            Text(
              'Date de naissance :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Sélectionner'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Niveau en programmation (1-5) :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text('Débutant'),
                Expanded(
                  child: Slider(
                    value: _competenceLevel,
                    min: 1.0,
                    max: 5.0,
                    divisions: 4,
                    label: _competenceLevel.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _competenceLevel = value;
                      });
                    },
                  ),
                ),
                Text('Expert'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Formation :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _formation,
              onChanged: (String? newValue) {
                setState(() {
                  _formation = newValue!;
                });
              },
              items: <String>['Informatique', 'Design', 'Marketing', 'Gestion']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recevoir des notifications :',
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: _notifications,
                  onChanged: (value) {
                    setState(() {
                      _notifications = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showProfile(context); // Call the method to show profile
                },
                child: Text('Valider le formulaire'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}