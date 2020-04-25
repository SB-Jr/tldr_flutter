import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MyApp());
}

class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

class ParentWidgetB extends StatefulWidget {
  @override
  _ParentWidgetBState createState() => _ParentWidgetBState();
}

class _ParentWidgetBState extends State<ParentWidgetB> {
  bool _tapBoxBActive = false;
  TapboxB tapboxB;

  void _handleTapBoxBChanged() {
    setState(() {
      _tapBoxBActive = !_tapBoxBActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    tapboxB = TapboxB(active: _tapBoxBActive, onChanged: _handleTapBoxBChanged);

    return Container(
      child: tapboxB,
    );
  }
}

class TapboxB extends StatelessWidget {
  final bool active;
  final Function onChanged;

  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        child: Center(
            child: Text(
          active ? 'Active' : 'Inactive',
          style: TextStyle(fontSize: 32, color: Colors.white),
        )),
        width: 200,
        height: 200,
        decoration:
            BoxDecoration(color: active ? Colors.green[700] : Colors.grey[600]),
      ),
    );
  }
}

class ParentWidgetC extends StatefulWidget {
  @override
  State<ParentWidgetC> createState() => _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleWidgetCTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TapBoxC(
      active: _active,
      onChanged: _handleWidgetCTap,
    ));
  }
}

class TapBoxC extends StatefulWidget {
  final bool active;
  final Function onChanged;

  TapBoxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  @override
  State<TapBoxC> createState() => _TapBoxCState();
}

class _TapBoxCState extends State<TapBoxC> {
  bool _highlight = false;
  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged();
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapCancel: _handleTapCancel,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight ? Border.all(color: Colors.teal[700]) : null,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Managing State',
      home: Scaffold(
        appBar: AppBar(title: Text('Managing States')),
        body: ListView(children: [TapboxA(), ParentWidgetB(), ParentWidgetC()]),
      ),
    );
  }
}
