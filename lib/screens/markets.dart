import 'package:cryptotracker/models/cryptomodel.dart';
import 'package:cryptotracker/provider/market_provider.dart';

import 'package:cryptotracker/widgets/cryptolist_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isloading == true) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (marketProvider.markets.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: marketProvider.markets.length,
                  itemBuilder: (context, index) {
                    Crytocurrency currentcrypto = marketProvider.markets[index];
                    return CryptoListTile(currentCrypto: currentcrypto);
                  }),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: const Text(
                  "Data Not Found !  01403 ERROR",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            );
          }
        }
      },
    );
  }
}
