import 'package:flutter/material.dart';
//Pantallas de las listas con la info.

class ExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //appBar: AppBar(
        // title: const Text('Relax Spa'),
        //  ),
        body: ListView.builder(
          //lista ordenada de como se veran los obejtos en la pantalla
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

// clase que identifica a los demas ibejtos que utilizaremos para desplegar
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// los entry que seran desplegados
final List<Entry> data = <Entry>[
  Entry(
    'Horario SPA',
    <Entry>[
      //tendran un hijo en donde ira la informacion dentro del desplegue
      Entry('Domingos a Jueves de 10 a 20 hs.'),
      Entry('Viernes y Sábados de 10 a 21 hs.'),
      Entry(
          'Fines de semana feriados y fechas especiales: de 10 hs. a 12 hs. y después de las 18hs'),
      Entry(
          'Los menores de 16 años pueden ingresar al sector de Spa a partir de las 18 hs. '),
    ],
  ),
  Entry(
    'Membresia ',
    <Entry>[
      Entry(
          'La membresía incluye el uso libre de todas las instalaciones del Spa (sauna seco, sauna húmedo, ducha escocesa, piscina climatizada cubierta, hidromasaje, piscina externa, cancha de tenis y solarium) de 10 a 19 hs de lunes a domingos.'),
      Entry('Entrega de toallas y un locker para guardar sus pertenencias. '),
      Entry('Ingreso de menores a piscina cubierta es a partir de las 18hs.'),
    ],
  ),
  Entry(
    'Nùmero',
    <Entry>[
      Entry('299654234'),
    ],
  ),
  Entry(
    'Contacto',
    <Entry>[
      Entry('tmariajuliana222@gmail.com'),
    ],
  ),
  Entry(
    'Ubicacion',
    <Entry>[
      Entry('Lanin 2020'),
    ],
  ),
  Entry(
    'Tratamientos Disponibles',
    <Entry>[
      Entry('Masaje con algas'),
      Entry('Tratamiento Q10'),
      Entry('Limpieza Facial'),
      Entry('Exfoliacióm'),
      Entry('Mascara rejuvenecedora'),
      Entry('Tonificación'),
      Entry('Hidtración Multivitaminica'),
    ],
  ),
];

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root), //flecha con la que se despega
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(), //mapea el children
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

void main() {
  runApp(ExpansionTileSample()); //corre nuestra listas
}
