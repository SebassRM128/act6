import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegación con 10 Pantallas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PantallaPrincipal(),
      routes: {
        '/pantalla2': (context) => const PantallaDos(),
        '/pantalla3': (context) => const PantallaTres(),
        '/pantalla4': (context) => const PantallaCuatro(),
        '/pantalla5': (context) => const PantallaCinco(),
        '/pantalla6': (context) => const PantallaGenerica(numeroPantalla: 6),
        '/pantalla7': (context) => const PantallaSiete(),
        '/pantalla8': (context) => const PantallaOcho(),
        '/pantalla9': (context) => const PantallaNueve(),
        '/pantalla10': (context) => const PantallaDiez(),
      },
    );
  }
}

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Principal'),
      ),
      body: Center(
        child: Wrap(
          spacing: 8.0,
          runSpacing: 12.0,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pantalla2');
              },
              child: const Text('Ir a Pantalla 2'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pantalla3');
              },
              child: const Text('Ir a Pantalla 3'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pantalla4');
              },
              child: const Text('Ir a Pantalla 4'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pantalla5');
              },
              child: const Text('Ir a Pantalla 5'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pantalla6');
              },
              child: const Text('Ir a Pantalla 6'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pantalla7');
              },
              child: const Text('Ir a Pantalla 7'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pantalla8');
              },
              child: const Text('Ir a Pantalla 8'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pantalla9');
              },
              child: const Text('Ir a Pantalla 9'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pantalla10');
              },
              child: const Text('Ir a Pantalla 10'),
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaDos extends StatefulWidget {
  const PantallaDos({super.key});

  @override
  State<PantallaDos> createState() => _PantallaDosState();
}

class _PantallaDosState extends State<PantallaDos>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 2'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _togglePlayPause,
          child: SizedBox(
            width: 100,
            height: 100,
            child: AnimatedIcon(
              icon: AnimatedIcons.pause_play,
              progress: _animationController,
              size: 80,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

class PantallaTres extends StatefulWidget {
  const PantallaTres({super.key});

  @override
  _PantallaTresState createState() => _PantallaTresState();
}

class _PantallaTresState extends State<PantallaTres> {
  final List<String> _items = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final TextEditingController _textController = TextEditingController();

  void _addItem(String newItem) {
    if (newItem.trim().isEmpty) return;
    _items.insert(0, newItem);
    _listKey.currentState
        ?.insertItem(0, duration: const Duration(milliseconds: 300));
  }

  void _removeItem(int index) {
    if (index < 0 || index >= _items.length) return;
    String removedItem = _items[index];
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, context, animation),
      duration: const Duration(milliseconds: 300),
    );
    _items.removeAt(index);
  }

  Widget _buildItem(
      String item, BuildContext context, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 4,
        child: ListTile(
          title: Text(item),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              int indexToRemove = _items.indexOf(item);
              if (indexToRemove != -1) {
                _removeItem(indexToRemove);
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Agregar a la lista',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                _addItem(value);
                _textController.clear();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addItem(_textController.text);
                _textController.clear();
              },
              child: const Text('Agregar'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: _items.length,
                itemBuilder: (context, index, animation) {
                  return _buildItem(_items[index], context, animation);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaCuatro extends StatefulWidget {
  const PantallaCuatro({super.key});

  @override
  _PantallaCuatroState createState() => _PantallaCuatroState();
}

class _PantallaCuatroState extends State<PantallaCuatro>
    with SingleTickerProviderStateMixin {
  // Controlador para la animación
  late AnimationController _animationController;
  // Variable para controlar la visibilidad del barrier
  bool _showBarrier = false;

  @override
  void initState() {
    super.initState();
    // Inicializa el AnimationController con una duración
    _animationController = AnimationController(
      vsync: this, // Usa el TickerProvider de este State
      duration: const Duration(seconds: 2), // Duración de la animación
    );
  }

  @override
  void dispose() {
    _animationController.dispose(); // Libera los recursos del controlador
    super.dispose();
  }

  // Función para mostrar/ocultar el barrier con animación
  void _toggleBarrier() {
    setState(() {
      _showBarrier = !_showBarrier; // Cambia el estado de visibilidad

      if (_showBarrier) {
        _animationController.forward(); // Inicia la animación hacia adelante
      } else {
        _animationController.reverse(); // Inicia la animación hacia atrás
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 4'),
      ),
      body: Center(
        child: Stack(
          children: [
            // Contenido principal de la pantalla
            Center(
              child: ElevatedButton(
                onPressed:
                    _toggleBarrier, // Llama a la función al presionar el botón
                child: const Text('Mostrar/Ocultar Barrier'),
              ),
            ),
            // AnimatedModalBarrier
            if (_showBarrier)
              FadeTransition(
                // Envuelve con FadeTransition para la animación de opacidad
                opacity: _animationController,
                child: ModalBarrier(
                  // Usa ModalBarrier en lugar de AnimatedModalBarrier
                  color: Colors.black.withOpacity(0.5),
                  dismissible: true,
                  onDismiss: () {
                    setState(() {
                      _showBarrier = false;
                      _animationController.reverse();
                    });
                  },
                ),
              ),
            // Mensaje opcional sobre el barrier
            if (_showBarrier)
              const Center(
                child: Text(
                  "¡Barrier Activo! Toca fuera para cerrar.",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Nueva clase para la Pantalla 5 con un Icon
class PantallaCinco extends StatefulWidget {
  const PantallaCinco({super.key});

  @override
  _PantallaCincoState createState() => _PantallaCincoState();
}

class _PantallaCincoState extends State<PantallaCinco>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isOpaque = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _animationController.value = 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleOpacity() {
    setState(() {
      _isOpaque = !_isOpaque;
      if (_isOpaque) {
        _animationController.animateTo(1.0);
      } else {
        _animationController.animateTo(0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 5'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: _animationController.value,
              duration: const Duration(seconds: 1),
              child: const Icon(
                Icons.flutter_dash, // Un icono de Flutter por defecto
                size: 200,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleOpacity,
              child: Text(_isOpaque ? 'Hacer Transparente' : 'Hacer Opaco'),
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaGenerica extends StatefulWidget {
  final int numeroPantalla;
  const PantallaGenerica({super.key, required this.numeroPantalla});

  @override
  State<PantallaGenerica> createState() => _PantallaGenericaState();
}

class _PantallaGenericaState extends State<PantallaGenerica>
    with SingleTickerProviderStateMixin {
  double _paddingHorizontal = 0.0;
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      _paddingHorizontal = _isExpanded ? 100.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.numeroPantalla == 6) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Pantalla ${widget.numeroPantalla}'),
        ),
        body: Center(
          child: AnimatedPadding(
            padding: EdgeInsets.only(
                left: _paddingHorizontal, right: _paddingHorizontal),
            duration: const Duration(seconds: 1), // Duración de la animación
            curve: Curves.easeInOut,
            child: Container(
              width: 200 +
                  (2 *
                      _paddingHorizontal), // El ancho se expande con el doble del padding
              height: 200,
              color: Colors.orange[300],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Padding Horizontal: ${_paddingHorizontal.toStringAsFixed(0)}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _toggleExpand,
                      child: Text(_isExpanded ? 'Collapse' : 'Expand'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Pantalla ${widget.numeroPantalla}'),
        ),
        body: Center(
          child: Text('Contenido de la Pantalla ${widget.numeroPantalla}'),
        ),
      );
    }
  }
}

// Nueva clase para la Pantalla 7 con el cuadrado blanco y la sombra
class PantallaSiete extends StatefulWidget {
  const PantallaSiete({super.key});

  @override
  State<PantallaSiete> createState() => _PantallaSieteState();
}

class _PantallaSieteState extends State<PantallaSiete> {
  bool _isShadowed = false;
  //double _elevation = 0; // The value of the field '_elevation' isn't used.
  Color _shadowColor = Colors.transparent;

  void _toggleShadow() {
    setState(() {
      _isShadowed = !_isShadowed;
      //_elevation = _isShadowed ? 20 : 0;
      _shadowColor = _isShadowed ? Colors.black54 : Colors.transparent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 7'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centra los elementos verticalmente
          children: <Widget>[
            GestureDetector(
              onTap: _toggleShadow,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    if (_isShadowed) // Use if condition.
                      BoxShadow(
                        color: _shadowColor,
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.android,
                    size: 60,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Espacio entre el cuadrado y el botón
            ElevatedButton(
              onPressed: _toggleShadow,
              child: const Text('Click'),
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaOcho extends StatefulWidget {
  const PantallaOcho({super.key});

  @override
  _PantallaOchoState createState() => _PantallaOchoState();
}

class _PantallaOchoState extends State<PantallaOcho> {
  bool _sizeChanged = false;
  bool _positionChanged = false;

  void _toggleSizeAndPosition() {
    setState(() {
      _sizeChanged = !_sizeChanged;
      _positionChanged = !_positionChanged;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 8'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: _sizeChanged ? 200.0 : 100.0,
              height: _sizeChanged ? 100.0 : 100.0,
              left: _positionChanged ? 100.0 : 0.0,
              top: _positionChanged ? 50.0 : 0.0,
              child: GestureDetector(
                onTap: _toggleSizeAndPosition,
                child: Container(
                  decoration: BoxDecoration(
                    // Added BoxDecoration
                    color: Colors.green,
                    borderRadius:
                        BorderRadius.circular(_sizeChanged ? 20.0 : 8.0),
                  ),
                  child: const Center(
                    child: Text(
                      '¡Cambia!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: ElevatedButton(
                onPressed: _toggleSizeAndPosition,
                child: const Text('Cambiar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla 9: Icono grande y botón para rotar
class PantallaNueve extends StatefulWidget {
  const PantallaNueve({super.key});

  @override
  _PantallaNueveState createState() => _PantallaNueveState();
}

class _PantallaNueveState extends State<PantallaNueve>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool _isRotating = false;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duración de la rotación
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _toggleRotation() {
    setState(() {
      _isRotating = !_isRotating;
      if (_isRotating) {
        _rotationController.repeat(); // Inicia la rotación continua
      } else {
        _rotationController.stop(); // Detiene la rotación
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 9'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RotationTransition(
              turns: _rotationController,
              child: const Icon(
                Icons.ac_unit, // Puedes cambiar este icono
                size: 200,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleRotation,
              child: Text(_isRotating ? 'Detener Rotación' : 'Rotar'),
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaDiez extends StatefulWidget {
  const PantallaDiez({super.key});

  @override
  _PantallaDiezState createState() => _PantallaDiezState();
}

class _PantallaDiezState extends State<PantallaDiez> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 10'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                '$_counter',
                key: ValueKey<int>(
                    _counter), // Important: Unique key for each value
                style:
                    const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Text('Incrementar Contador'),
            ),
          ],
        ),
      ),
    );
  }
}
