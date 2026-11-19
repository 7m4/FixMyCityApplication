import 'package:material_ui/material_ui.dart';
import 'package:fix_my_city_application/features/register/logic/controllers.dart';
class RegisterStep2 extends StatefulWidget {
  // const RegisterStep1({super.key});

  final RegisterController param; // Add the required parameter
  
   const RegisterStep2({
    super.key,
    required this.param,
  });

  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {

  @override
  void initState() {
    super.initState();
  }
  @override
    Widget build(BuildContext context) {
      
    return  ElevatedButton(onPressed: () {
            widget.param.previousPage(); // Call the previousPage

      print('Previous Step pressed');
      }
      , child: Text('Previous Step'),);
  }
}