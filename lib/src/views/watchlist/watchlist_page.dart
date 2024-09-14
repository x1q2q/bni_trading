import 'package:bni_trading/src/models/crypto_price.dart';
import 'package:flutter/material.dart';
import 'package:bni_trading/src/utils/index.dart';
import 'watchlist_view.dart';
import 'package:provider/provider.dart';
import 'package:bni_trading/src/viewmodels/crypto_viewmodel.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    super.initState();
    final cryptoViewmodel =
        Provider.of<CryptoViewmodel>(context, listen: false);
    cryptoViewmodel
        .subscribe('{"action":"subscribe", "symbols":"ETH-USD, BTC-USD"}');
  }

  @override
  void dispose() {
    final cryptoViewmodel =
        Provider.of<CryptoViewmodel>(context, listen: false);
    cryptoViewmodel.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CryptoViewmodel>(builder: (context, viewModel, child) {
      if (viewModel.cryptoPrice != null) {
        return Column(children: <Widget>[
          _buldTile(() {}, _buildContent(viewModel.ethPrice!)),
          AppStyles.yGapSm,
          _buldTile(() {}, _buildContent(viewModel.btcPrice!))
        ]).addPd(all: 10);
      }
      return const Center(child: CircularProgressIndicator());
    });
  }

  Widget _buildContent(CryptoPrice? item) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item!.tickerCode!),
                Text(item.tickerCode!)
              ]),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                Text("${item.lastPrice!}USD"),
                Text("${item.dailyDiffPrice}-(${item.dailyChangePerc}%)")
              ])),
        ]);
  }

  Widget _buldTile(Function() onTap, Widget widget, {double height = 75}) {
    return SizedBox.fromSize(
            child: Container(
                    height: height,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: widget)
                .addInkWell(
                    color: AppColors.lightgray,
                    splash: Colors.white54,
                    onPress: onTap))
        .addBdRadius(18);
  }
}
