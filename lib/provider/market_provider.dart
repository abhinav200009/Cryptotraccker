import 'package:cryptotracker/models/api.dart';
import 'package:cryptotracker/models/cryptomodel.dart';
import 'package:cryptotracker/models/local_storage.dart';
import 'package:flutter/widgets.dart';

class MarketProvider with ChangeNotifier {
  bool isloading = true;
  List<Crytocurrency> markets = [];
  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await Api.getMarket();
    List<String> favorites = await LocalStorage.fetchfavorites();

    List<Crytocurrency> temp = [];
    for (var markets in _markets) {
      Crytocurrency newcrypto = Crytocurrency.fromJSON(markets);
      if (favorites.contains(newcrypto.id!)) {
        newcrypto.isfavorite = true;
      }
      temp.add(newcrypto);
    }
    markets = temp;
    isloading = false;
    notifyListeners();

    // Timer(const Duration(seconds: 3), () {
    //   fetchData();
    // });
  }

  Crytocurrency fetchCryptoById(String id) {
    Crytocurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFavorite(Crytocurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isfavorite = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  void removeFavorite(Crytocurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isfavorite = false;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }
}
