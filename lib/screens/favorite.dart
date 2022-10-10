import 'package:cryptotracker/models/cryptomodel.dart';
import 'package:cryptotracker/provider/market_provider.dart';
import 'package:cryptotracker/widgets/cryptolist_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<Crytocurrency> favorites = marketProvider.markets
            .where((element) => element.isfavorite == true)
            .toList();
        if (favorites.length > 0) {
          return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                Crytocurrency currentcrypto = favorites[index];
                return CryptoListTile(currentCrypto: currentcrypto);
              });
        } else {
          return Center(
            child: Text("No favorites Found"),
          );
        }
      },
    ));
  }
}
