import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class _FavouriteWidgetState extends State<FavoriteWidget> {
  bool _isFavourite = true;
  int _favouriteCount = 41;

  void _toggleFavourite(){
    setState(() {
      if (_isFavourite) {
        _favouriteCount -= 1;
        _isFavourite = false;
      } else {
        _favouriteCount += 1;
        _isFavourite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavourite ? Icon(Icons.star): Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavourite,
          )
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favouriteCount'),
          ),
        )
      ],
    );
  }
}


class FavoriteWidget extends StatefulWidget {
  @override
  _FavouriteWidgetState createState() => _FavouriteWidgetState();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Widget titleSection = Container (
      padding: EdgeInsets.all(32),
      child: Row (
        children: [
          Expanded(  //the first child inside the row  -> contains 2 rows of texts
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                        'Oeschinen Lake Campground',
                        style: TextStyle(fontWeight: FontWeight.bold)) //The Heading,
                ),
                Text(  //the subtext
                  'Kandersteg, Switzerland',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          FavoriteWidget(),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = Container (
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE')
        ],
      )
    );

    Widget textSection = Container (
      padding: EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      )
    );

    Image imageSection = Image.asset(
      'images/lake.jpg',
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );


    return MaterialApp(
      title: 'Flutter layouts',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Futter Layouts Demo'),
        ),
        body : ListView (
          children: [
            imageSection,
            titleSection,
            buttonSection,
            textSection
          ],
        )
      ),
    );
  }


  Column _buildButtonColumn(Color color, IconData icon, String label){
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color,),
          Container(
              child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: color,
                  )
              )
          )
        ]
    );
  }
}

