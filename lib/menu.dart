import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  // Color verde azulado oscuro / petróleo para los iconos
  static const Color prakiIconColor = Color(0xFF234443);

  final List<Widget> _pages = const [
    Center(
      child: Text(
        "🏠 Inicio",
        style: TextStyle(fontSize: 24, color: prakiIconColor), // Texto también con el color azulado
      ),
    ),
    Center(
      child: Text(
        "💙 Cuidado",
        style: TextStyle(fontSize: 24, color: prakiIconColor),
      ),
    ),
    Center(
      child: Text(
        "🔥 Racha",
        style: TextStyle(fontSize: 24, color: prakiIconColor),
      ),
    ),
    Center(
      child: Text(
        "🤖 Praki IA",
        style: TextStyle(fontSize: 24, color: prakiIconColor),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F0F0), // Fondo de pantalla (color de paleta)

      body: SafeArea(
        child: _pages[_selectedIndex],
      ),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFEEE3DF), // Fondo de la barra (color de paleta)
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent, 
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          // Aplicamos el color azulado solo a los iconos y etiquetas
          selectedItemColor: prakiIconColor, 
          unselectedItemColor: prakiIconColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Inicio",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded),
              label: "Cuidado",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department_rounded),
              label: "Racha",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.smart_toy_rounded),
              label: "Praki IA",
            ),
          ],
        ),
      ),
    );
  }
}