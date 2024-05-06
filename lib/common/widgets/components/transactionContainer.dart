import 'package:flutter/material.dart';
import 'package:kradadtod/utils/constants/colors.dart';
import 'package:kradadtod/utils/formatters/formatters.dart';

class TransactionContainer extends StatelessWidget {
  const TransactionContainer({
    super.key,
    required this.accountName,
    required this.category,
    required this.balance,
    required this.bankCode,
    required this.date,
  });

  final String accountName;
  final String category;
  final String bankCode;
  final Widget balance;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(bankCode),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  accountName.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: KAppColors.azure.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Text(
                      category,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: KAppColors.azure),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                balance,
                Text(
                  date,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
