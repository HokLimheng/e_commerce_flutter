import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  OutlineInputBorder? border;
  TextEditingController bankName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    bankName = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white30,
        title: Text('Payment', style: TextStyle(fontWeight: FontWeight.w600),),
      ),
      body:  Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/card_bg.png'),
            fit: BoxFit.fill,
          ),
          color: Colors.white,
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              CreditCardWidget(
                glassmorphismConfig: Glassmorphism.defaultConfig(),
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                bankName: bankName.text,
                frontCardBorder: Border.all(color: Colors.grey),
                backCardBorder: Border.all(color: Colors.grey),
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                isHolderNameVisible: true,
                cardBgColor: Colors.black,
                backgroundImage: 'assets/images/card_bg.png',
                isSwipeGestureEnabled: true,
                onCreditCardWidgetChange:
                    (CreditCardBrand creditCardBrand) {},
                customCardTypeIcons: <CustomCardTypeIcon>[
                  CustomCardTypeIcon(
                    cardType: CardType.mastercard,
                    cardImage: Image.asset(
                      'assets/images/mastercard.png',
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 17, right: 17, top: 20),
                        child: TextFormField(
                          controller: bankName,
                          style: const TextStyle(color: Colors.white),
                          onEditingComplete: (() => setState(() {})),
                          decoration: InputDecoration(
                            labelText: 'Bank Name',
                            hintText: 'ICICI Bank',
                            hintStyle: const TextStyle(color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            focusedBorder: border,
                            enabledBorder: border,
                          ),
                        ),
                      ),
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        isHolderNameVisible: true,
                        isCardNumberVisible: true,
                        isExpiryDateVisible: true,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        // themeColor: Colors.blue,
                        inputConfiguration: const InputConfiguration(
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Card Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: TextStyle(color: Colors.white30),
                            labelStyle: TextStyle(color: Colors.white70),
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white30),
                            labelStyle: TextStyle(color: Colors.white70),
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white30),
                            labelStyle: TextStyle(color: Colors.white70),
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(

                            hintStyle: TextStyle(color: Colors.white30),
                            labelStyle: TextStyle(color: Colors.white70),
                            labelText: 'Card Holder',
                          ),
                        ),

                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: _onValidate,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: <Color>[
                                Colors.purple,
                                Colors.purpleAccent,
                                Colors.deepPurple
                              ],
                              begin: Alignment(-1, -4),
                              end: Alignment(1, 4),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const Text(
                            'Validate',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'halter',
                              fontSize: 14,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _onValidate() {
    if (formKey.currentState!.validate()) {
      _showValidDialog(context, "Valid", "Your card successfully valid !!!");
    } else {
      _showValidDialog(context, "Not Valid", "Try Again !!!");
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  _showValidDialog(
      BuildContext context,
      String title,
      String content,
      ) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(title),
          content: Text(content),
        );
      },
    );
  }

}



