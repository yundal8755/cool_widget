import 'package:cool_widget/app/widget/component/button/cool_button.dart';
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
    super.initState();
    viewModel = HomeViewModel(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cool Widget'),
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "진행중",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                _buildGrid(viewModel.completedWidgetNames),

                const SizedBox(height: 24),

                const Text(
                  "대기중",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // 4) 미완성 위젯들 Grid
                _buildGrid(viewModel.incompleteWidgetNames),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<String> names) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: names.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final widgetName = names[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CoolButton(
            onPressed: () => viewModel.routeToWidgetPage(context, widgetName),
            child: SizedBox.expand(
              child: Center(
                child: Text(widgetName, overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        );
      },
    );
  }
}
