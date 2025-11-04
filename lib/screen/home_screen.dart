import 'package:crypto_academy/utils/app_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<FlSpot> chartData = const [
    FlSpot(0, 8),
    FlSpot(1, 8.2),
    FlSpot(2, 8.1),
    FlSpot(3, 7.8),
    FlSpot(4, 7.5),
    FlSpot(5, 7.0),
    FlSpot(6, 6.5),
    FlSpot(7, 6.8),
    FlSpot(8, 6.0),
    FlSpot(9, 5.5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Home", false, context),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 0, 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _recent(
                      "Rewards",
                      "Like, Share & get free coupons",
                      Colors.deepPurpleAccent,
                      "assets/images/150.jpeg",
                      "Share Now",
                    ),
                    _recent(
                      "Rewards",
                      "Like, Share & get free coupons",
                      Colors.deepPurpleAccent,
                      "assets/images/150.jpeg",
                      "Share Now",
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Chart"),
                    TextButton(onPressed: () {}, child: Text("See All")),
                  ],
                ),
              ),
              _chartCrypto(
                "assets/images/150.jpeg",
                "BTC",
                "BITCOIN",
                chartData,
                "2985015",
                "-11.75%",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chartCrypto(
    String iconCrypto,
    String ticker,
    String name,
    List<FlSpot> charData,
    String currency,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(iconCrypto, height: 40, width: 40),
          ),
          SizedBox(width: 5,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ticker),
                Text(name)]),
          SizedBox(width: 5,),
          _stockChart(charData),
          SizedBox(width: 5,),
          
          Column(children: [Text("\$$currency"), Text(value)]),
        ],
      ),
    );
  }

  Widget _stockChart(List<FlSpot> chartDataa) {
    return Container(
      height: 50,
      width: 100,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: chartDataa,
              isCurved: true,
              color: Colors.red,
              barWidth: 0.5,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recent(
    String subName,
    String nameCourse,
    Color color,
    String image,
    String nameLabel,
  ) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 300,
          height: 150,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "$subName",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        nameCourse,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            alignment: Alignment.center,
                            fixedSize: Size(double.infinity, 0),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "$nameLabel",
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(image),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
