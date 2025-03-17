import 'package:cool_widget/app/widget/component/button/button.dart';
import 'package:cool_widget/screen/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    viewModel = HomeViewModel(this);
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>.value(
      value: viewModel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cool Widget'),
          ),
          body: GridView.builder(
            itemCount: viewModel.widgetNames.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) {
              final String widgetName = viewModel.widgetNames[index];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: PrimaryButton(
                  title: widgetName,
                  onPressed: () =>
                      viewModel.routeToWidgetPage(context, widgetName),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
