import 'package:crypto_academy/provider/crypto_provider.dart';
import 'package:crypto_academy/utils/app_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import model dan state yang diperlukan
import 'package:crypto_academy/data/model/final_combined_asset.dart';
import 'package:crypto_academy/static/CryptoResultStatic.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Data chart statis (Placeholder karena data historis tidak tersedia di API Anda)
  final List<FlSpot> chartData = const [
    FlSpot(0, 8), FlSpot(1, 8.2), FlSpot(2, 8.1), FlSpot(3, 7.8),
    FlSpot(4, 7.5), FlSpot(5, 7.0), FlSpot(6, 6.5), FlSpot(7, 6.8),
    FlSpot(8, 6.0), FlSpot(9, 5.5),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CryptoProvider>(context, listen: false).fetchCombineData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CryptoProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: appBar("Home", false, context),
          body: Padding(
            padding: EdgeInsets.fromLTRB(24, 24, 0, 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _recent("Rewards", "Like, Share & get free coupons", Colors.deepPurpleAccent, "assets/images/150.jpeg", "Share Now"),
                        _recent("Rewards", "Like, Share & get free coupons", Colors.deepPurpleAccent, "assets/images/150.jpeg", "Share Now"),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Chart", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        TextButton(onPressed: () {}, child: Text("See All")),
                      ],
                    ),
                  ),

                  // _buildCryptoList(provider),

                  // Center(
                  //   child: IconButton(
                  //       onPressed: () async {
                  //         if (provider.assets.isEmpty || provider.resultState is! CryptoResultLoadedResultState) {
                  //           ScaffoldMessenger.of(context).showSnackBar(
                  //             SnackBar(content: Text("Data belum siap atau gagal dimuat.")),
                  //           );
                  //           return;
                  //         }
                  //         String result = await provider.exportAssetsToFile();
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(content: Text(result)),
                  //         );
                  //       },
                  //       icon: Icon(Icons.download_for_offline, size: 30, color: Colors.blueAccent)
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCryptoList(CryptoProvider provider) {
    if (provider.resultState is CryptoResultLoadingResultState) {
      return Center(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: const CircularProgressIndicator(),
      ));
    }

    if (provider.resultState is CryptoResultErrorResultState) {
      final errorState = provider.resultState as CryptoResultErrorResultState;
      return Center(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(errorState.error ?? "Gagal memuat data aset.", style: TextStyle(color: Colors.red)),
      ));
    }

    if (provider.resultState is CryptoResultLoadedResultState && provider.assets.isNotEmpty) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(), // Nonaktifkan scroll internal
        shrinkWrap: true,
        itemCount: provider.assets.length,
        itemBuilder: (context, index) {
          final asset = provider.assets[index];

          final ticker = asset.symbol;
          final name = asset.name;
          final value = asset.last ?? 'N/A';
          final change = asset.daily_change_precentage ?? '0.00';

          const iconPath = "assets/images/150.jpeg";

          return _chartCrypto(
            iconPath,
            ticker,
            name,
            chartData,
            value,
            change,
          );
        },
      );
    }

    return const Center(child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Text("Tidak ada aset yang ditemukan."),
    ));
  }

  Widget _chartCrypto(
      String iconCrypto,
      String ticker,
      String name,
      List<FlSpot> charData,
      String value,
      String change,
      ) {
    final isNegative = change.contains('-');
    final changeColor = isNegative ? Colors.red : Colors.green;

    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(iconCrypto, height: 40, width: 40),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ticker, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(name, style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),

          _stockChart(charData),

          Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("\$$value", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("$change%", style: TextStyle(color: changeColor, fontSize: 12)),
              ]
          ),
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