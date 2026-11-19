import 'package:fix_my_city_application/features/register/logic/register_form.dart';
import 'package:material_ui/material_ui.dart';

class RegisterController {

  
  // Add your controller logic here
  final ValueNotifier<RegisterForm> registerForm = ValueNotifier(RegisterForm());
  final PageController pageController = PageController();
  final ValueNotifier<int> indexNotifier = ValueNotifier(0);

  void OnPageChanged(int index) {
    indexNotifier.value = index;
    
  }

  void nextPage() {
    if (pageController.hasClients) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (pageController.hasClients) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }


  void dispose() {
    registerForm.dispose();
    pageController.dispose();
    indexNotifier.dispose();
  }

}

