import 'package:get/state_manager.dart';
import 'package:ibuild_dash/models/agent.dart';
import 'package:ibuild_dash/models/main_route.dart';
import 'package:ibuild_dash/screens/dashboard/dashboard_screen.dart';

class UserController {
  Agent? agent;
  Agent get adm => agent!;

  RxString homePage = RxString('Dashboard');
  Rx<MainRoute> home = Rx(MainRoute('Dashboard', DashboardScreen()));
}
