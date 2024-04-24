import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher', style: TextStyle(fontWeight: FontWeight.w600),),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          VoucherCard(percentage: '50', name: 'Black Friday', code: 'Friday', date: 20, month: 'dec',),
          VoucherCard(percentage: '50', name: 'Black Friday', code: 'Friday', date: 20, month: 'dec',),
          VoucherCard(percentage: '50', name: 'Black Friday', code: 'Friday', date: 20, month: 'dec',),
        ],
      ),
    );
  }
}



class VoucherCard extends StatelessWidget {
  final String percentage;
  final String name;
  final String code;
  final int date;
  final String month;

  const VoucherCard({
    super.key,
    required this.percentage,
    required this.name,
    required this.code,
    required this.date,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x1E000000),
            blurRadius: 24,
            offset: Offset(0, 2),
            spreadRadius: 4,
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(width: 20),
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: Color(0xFF22262E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '$percentage%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.40,
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Color(0xFF42474A),
                  fontSize: 16,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Sale off $percentage',
                style: TextStyle(
                  color: Color(0xFF6D758A),
                  fontSize: 12,
                  fontFamily: 'Product Sans Medium',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Code: $code',
                style: TextStyle(
                  color: Color(0xFF42474A),
                  fontSize: 14,
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Exp. $date $month',
                style: TextStyle(
                  color: Color(0xFF777E90),
                  fontSize: 12,
                  fontFamily: 'Product Sans Medium',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
