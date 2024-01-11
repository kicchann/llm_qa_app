// packages
import 'package:botob/view/page/new_content/component/text_content_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// constants
import 'package:botob/constant/strings.dart';

// view
import 'package:botob/view/page/new_content/component/file_content_component.dart';

class NewContentPage extends HookWidget {
  const NewContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    final index = useState(0);
    final key = GlobalKey();

    tabController.addListener(() {
      index.value = tabController.index;
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(newContentPageTitle),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            TabBar(
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.label,
              tabAlignment: TabAlignment.center,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              tabs: const [
                Tab(
                  icon: Icon(Icons.file_present_outlined),
                  text: useFileTabText,
                ),
                Tab(
                  icon: Icon(Icons.edit_outlined),
                  text: inputDirectlyText,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                key: key,
                controller: tabController,
                children: const [
                  FileContentComponent(),
                  TextContentComponent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
