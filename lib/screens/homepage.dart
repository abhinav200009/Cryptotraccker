import 'package:cryptotracker/provider/theme_provider.dart';
import 'package:cryptotracker/screens/favorite.dart';
import 'package:cryptotracker/screens/markets.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late TabController viewController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Welcome",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Crypto Today",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () {
                        themeProvider.toggleTheme();
                      },
                      padding: EdgeInsets.all(0),
                      icon: (themeProvider.themeMode == ThemeMode.light)
                          ? Icon(Icons.dark_mode)
                          : Icon(Icons.light_mode))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TabBar(
                controller: viewController,
                tabs: [
                  Tab(
                    child: Text("Markets",
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  Tab(
                    child: Text("Favorites",
                        style: Theme.of(context).textTheme.bodyText1),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    controller: viewController,
                    children: [Markets(), Favorites()]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
