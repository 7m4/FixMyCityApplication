import 'package:fix_my_city_application/features/register/logic/controllers.dart';
import 'package:fix_my_city_application/features/register/presentation/widgets/register_steps/register_step_1.dart';
import 'package:fix_my_city_application/features/register/presentation/widgets/register_steps/register_step_2.dart';
import 'package:material_ui/material_ui.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _registerController = RegisterController();

  @override
  void dispose() {
    _registerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _registerController.pageController,
        onPageChanged: _registerController.OnPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children:  [
          RegisterStep1(param: _registerController), // Pass the required parameter to RegisterStep1
          RegisterStep2(param: _registerController), // Pass the required parameter to RegisterStep2
          // Add other steps here
        ],
      ),
    );
  }
}