import '../../consts/imports.dart';

class WorkInProgressPage extends StatefulWidget {
  const WorkInProgressPage({super.key});

  @override
  State<WorkInProgressPage> createState() => _WorkInProgressPageState();
}

class _WorkInProgressPageState extends State<WorkInProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (val) {
          final BottomNavController controller = Get.find();
          controller.tappedIndexFunc(0);
        },
        child: Center(
            child: Image.asset(
          XImages.work_in_progress,
          height: MediaQuery.of(context).size.height,
        )),
      ),
    );
  }
}
