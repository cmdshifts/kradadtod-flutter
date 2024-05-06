import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kradadtod/common/widgets/appBar/commonAppBar.dart';
import 'package:kradadtod/utils/constants/sizes.dart';
import 'package:kradadtod/utils/formatters/formatters.dart';
import 'package:kradadtod/utils/http/httpClient.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AchievementState();
}

class _AchievementState extends State<AchievementScreen> {
  DateTime selectedDate = DateTime.now();
  int? amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonAppBar(
            showBackArrow: true,
            title: Text(
              "Set Target",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Target Amount",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: KAppSizes.sm,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12.0),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(KAppSizes.md),
                      child: const Icon(FluentIcons.money_16_regular),
                    ),
                    hintText: "Amount",
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onChanged: (value) {
                    amount = int.tryParse(value);
                  },
                ),
                const SizedBox(
                  height: KAppSizes.sm,
                ),
                Text(
                  "Start from",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: KAppSizes.sm,
                ),
                GestureDetector(
                  onTap: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                    );

                    if (dateTime != null) {
                      setState(() {
                        selectedDate = dateTime;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(KAppSizes.md),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Text(
                      KAppFormatters.formatDate(selectedDate, null),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: TextButton(
              onPressed: () {
                if (amount != null) {
                  Map<String, dynamic> requestBody = {
                    'achievementId': 1,
                    'memberId': 1,
                    'amount': amount,
                    'date':
                        KAppFormatters.formatDate(selectedDate, "yyyy-MM-dd"),
                  };

                  KAppHttpHelper.put("achievement", requestBody).then((_) {
                    Navigator.pop(context);
                  });

                  Fluttertoast.showToast(
                    msg: "Successfully updated!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.grey.shade100.withOpacity(0.7),
                    textColor: Colors.black,
                    fontSize: 16.0,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Amount cannot be invalid!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.grey.shade100.withOpacity(0.7),
                    textColor: Colors.black,
                    fontSize: 16.0,
                  );
                }
              },
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  "Update",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
