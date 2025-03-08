import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home:SignupScreen(),
      debugShowCheckedModeBanner: false,
    ));
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body :SingleChildScrollView(
     
        child: Column(
        children: [
          SizedBox(height: 100),

          Align(
            
            alignment: Alignment.topCenter,
            child: Text("SPELL CHAMP",               
           style: TextStyle(
           
           fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )
            )
          ),
          SizedBox(height: 30),

          Text("Signup",       //page title
          style: TextStyle(
            fontSize: 24,
            color: Colors.black
          ),
          ),
          SizedBox(height: 20),

          Padding(padding:EdgeInsets.symmetric(horizontal: 20),        //box space
          child: Form(
            child: Column(
              children: [
                TextFormField(                                         //Name
                  keyboardType: TextInputType.name,
                   decoration: InputDecoration(
                    labelText: "NAME",                                 
                    hintText: "Enter your Name",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value ){}
                ),
                SizedBox(height: 20),

                TextFormField(                                       //email
                  keyboardType: TextInputType.emailAddress,     
                  decoration: InputDecoration(
                  labelText: "Email",
                    hintText: 'Enter your Emailid',
                    border: OutlineInputBorder()
                  ),
                  onChanged: (String value){},

                  validator: (value){                                //condition for email
                    if (value == null || value.isEmpty){ 
                      return "Please enter email" ;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                TextFormField(                                       //password
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){},


                   validator: (value) {                             //condition for password
                  if (value == null || value .isEmpty ) {
                    return "please enter your password" ;
                  } else if(value.length < 6){
                    return "Password must contain atleast 6 characters" ;
                  }
                  return null;
                },
              ),
              
                 SizedBox(height: 30),
              Column(
                children: [
                ElevatedButton(onPressed: () {},
                 child: Text("Signup"))                                  //signup button
                ],
              )
              ],
            ),
            ),
          ),
           Row (
          children: [
            Expanded(
            child: Divider(
              color:Colors.black,
              thickness: 1,
            ),
         ),
         Padding(
          padding:EdgeInsets.symmetric(horizontal:10),
          child:Text(
            "also Signup with ",
            style: TextStyle(fontSize:18,fontWeight: FontWeight.bold),
          ),
         ),
         Expanded(
          child: Divider(
            color: Colors.black,
            thickness:1
          ),
         ),
          ],
           ),
           SizedBox(height: 20),
           
           Column(
            children: [
              ElevatedButton(onPressed: () {},
               child: Text('Google'))
            ],
           )
        ],
      )
      )
      );
    
      
      
    }
}
      
      
    
          

     
          
          

  



  

