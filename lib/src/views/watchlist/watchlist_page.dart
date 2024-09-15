import 'package:bni_trading/src/models/crypto_price.dart';
import 'package:flutter/material.dart';
import 'package:bni_trading/src/utils/index.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bni_trading/src/viewmodels/crypto_viewmodel.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  CryptoViewmodel? viewModel;
  @override
  void initState() {
    viewModel = Provider.of<CryptoViewmodel>(context, listen: false);
    viewModel
        ?.subscribe('{"action":"subscribe", "symbols":"ETH-USD, BTC-USD"}');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<CryptoViewmodel>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    final viewModel = Provider.of<CryptoViewmodel>(context, listen: false);
    viewModel.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CryptoViewmodel?>(builder: (context, viewModel, child) {
      if (viewModel!.ethPrice != null && viewModel.btcPrice != null) {
        return Column(children: <Widget>[
          _buldTile(() {}, _buildContent(viewModel.ethPrice!)),
          AppStyles.yGapSm,
          _buldTile(() {}, _buildContent(viewModel.btcPrice!))
        ]).addPd(all: 10);
      }
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          AppStyles.yGapSm,
          Text(
            "Loading...",
            style: AppStyles.primBold(16),
          )
        ],
      ));
    });
  }

  Widget _buildContent(CryptoPrice? item) {
    String s = "\$";
    String typeCoin = item!.tickerCode == 'ETH-USD' ? 'Etherium' : 'Bitcoin';
    String assetsImg = item.tickerCode == 'ETH-USD'
        ? "ethereum-eth-logo.png"
        : "bitcoin-btc-logo.png";
    String dialyDifference = (item.dailyDiffPrice!.isNegative)
        ? "${item.dailyDiffPrice}"
        : "+${item.dailyDiffPrice}";
    String dcPercentage = (item.dailyChangePerc!.isNegative)
        ? "(${item.dailyChangePerc}%)"
        : "(+${item.dailyChangePerc}%)";
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Image.asset(height: 64, width: 64, "assets/images/$assetsImg"),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      typeCoin,
                      style: AppStyles.primBold(20),
                    ),
                    Text(item.tickerCode!)
                  ])
            ],
          )),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "$s ${NumberFormat("#,###", "en_US").format(item.lastPrice!)}",
                  style: AppStyles.primBold(16),
                ),
                Text(
                  "$dialyDifference $dcPercentage",
                  style: (item.dailyDiffPrice!.isNegative)
                      ? AppStyles.primLight(14, Colors.red)
                      : AppStyles.primLight(14),
                )
              ]),
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
