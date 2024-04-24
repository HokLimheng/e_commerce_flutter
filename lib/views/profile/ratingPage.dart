import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'widgets/shadowTextField.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share your feedback', style: TextStyle(fontWeight: FontWeight.w600),),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const Text('What is your opinion of GemStore?', style: TextStyle(
                fontSize: 18,
                fontFamily: ''
              ),
              ),

              const SizedBox(height: 20),
              // Rating bar
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating){
                  print(rating);
                },
              ),
              SizedBox(height: 90),
              // Text Field
              ShadowedTextFieldBox(hintText: 'Would you like to write anything about this product? ',),

              const SizedBox(height: 130),

              // Send Feedback button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(79, 152, 146, 1),
                  minimumSize: const Size(203, 48),
                ),
                onPressed: (){},
                child: const Text('Send Feedback', style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'ProductSans',
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

