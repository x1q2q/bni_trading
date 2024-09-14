import 'package:flutter/material.dart';
// import 'dashboard_view.dart';
import 'package:provider/provider.dart';
import 'package:bni_trading/src/viewmodels/crypto_viewmodel.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
      if (viewModel.cryptoPrice == null) {
        return const Center(child: CircularProgressIndicator());
      }
      final price = viewModel.cryptoPrice!;
      return ListTile(
          title: Text(price.tickerCode!),
          subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Price: ${price.lastPrice!.toStringAsFixed(2)} USD'),
                Text('Quantity: ${price.qtyTrade!.toStringAsFixed(6)}'),
                Text(
                    'Change: ${price.dailyChangePerc!.toStringAsFixed(2)}% (${price.dailyDiffPrice!.toStringAsFixed(2)} USD)'),
                Text('TImestamp: ${price.timestamp!.toLocal()}'),
              ]));
    });
  }
}
