import 'package:fix_my_city_application/core/widgets/custom_primary_button.dart';
import 'package:material_ui/material_ui.dart';
import 'package:fix_my_city_application/features/register/logic/controllers.dart';
class RegisterStep1 extends StatefulWidget {
  // const RegisterStep1({super.key});

  final RegisterController param; // Add the required parameter

   const RegisterStep1({
    super.key,
    required this.param,
  });

  @override
  State<RegisterStep1> createState() => _RegisterStep1State();
}

class _RegisterStep1State extends State<RegisterStep1> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPrimaryButton(text: "Next", onPressed: (){
      print('Next Step pressed');
        widget.param.nextPage(); // Call the nextPage method from the controller
      
      }),
    );
    // return  ElevatedButton(onPressed: () {
        //   }, child: Text('Next Step'),);
    // Text('Register Step 1', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),);
  }
}