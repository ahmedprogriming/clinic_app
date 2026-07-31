import 'package:clinic_app/widget/custom_card.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

 String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        //key: formKey,
        child: ListView(
          children: [
            SizedBox(height: 25),
            Image.asset('lib/assets/images/logo.png', height: 150),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "مرحبا دكتور ",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text(
                  
                 _formatDate(DateTime.now()),
                
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
              children: [
                
              CustomCard(text: 'المرضى',),
          
               CustomCard(text: 'المستخدمين',),
              
              ],
            ),
               SizedBox(height: 20,),
              Center(child: CustomCard(text: 'مواعيد العيادة',)),
           
          ],
        ),
      ),
    );
  }
}
