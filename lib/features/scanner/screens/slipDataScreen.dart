import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kradadtod/common/widgets/appBar/commonAppBar.dart';
import 'package:kradadtod/common/widgets/components/choiceButton.dart';
import 'package:kradadtod/navigation.dart';
import 'package:kradadtod/utils/constants/sizes.dart';
import 'package:kradadtod/utils/formatters/formatters.dart';
import 'package:kradadtod/utils/http/httpClient.dart';
import 'package:page_transition/page_transition.dart';

class SlipDataScreen extends StatefulWidget {
  const SlipDataScreen({super.key, required this.slipCode});

  final String slipCode;

  @override
  State<StatefulWidget> createState() => _SlipDataState();
}

class _SlipDataState extends State<SlipDataScreen> {
  int? _selectedCategory = 1;
  int? _selectedType = 1;
  int? memberId;
  String? receiverName;
  String? receiverAccountId;
  int? receiverBankCode;
  String? senderName;
  String? senderAccountId;
  int? senderBankCode;
  double? amount;
  String? currency;
  String? uploadDate;
  String? uploadTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommonAppBar(
            showBackArrow: true,
            title: Text("Slip Detail"),
          ),
          FutureBuilder(
            future: KAppHttpHelper.get(
                "transaction/getSlipData?value=${widget.slipCode}"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final response = snapshot.data;

                memberId = 1;
                receiverName = response['data']['receiver']['name'];
                receiverAccountId =
                    response['data']['receiver']['account']['value'];
                receiverBankCode =
                    int.tryParse(response['data']['receivingBank']);
                senderName = response['data']['sender']['name'];
                senderAccountId =
                    response['data']['sender']['account']['value'];
                senderBankCode = int.tryParse(response['data']['sendingBank']);
                amount = response['data']['amount'];
                currency = "THB";
                uploadDate = KAppFormatters.formatDate(
                    DateTime.parse(response['data']['transDate']),
                    "yyyy-MM-dd");
                uploadTime = response['data']['transTime'];

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 80,
                                    maxWidth: 80,
                                  ),
                                  child: Text(
                                    "From :",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    KAppFormatters.capitalizeWords(
                                        response['data']['sender']['name']),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    response['data']['sender']['account']
                                        ['value'],
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: KAppSizes.sm,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 80,
                                    maxWidth: 80,
                                  ),
                                  child: Text(
                                    "To :",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    KAppFormatters.capitalizeWords(
                                        response['data']['receiver']['name']),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    response['data']['receiver']['account']
                                        ['value'],
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: KAppSizes.md,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 80,
                                    maxWidth: 80,
                                  ),
                                  child: Text(
                                    "Amount :",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    KAppFormatters.formatMoney(
                                        response['data']['amount']),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                FutureBuilder(
                  future: KAppHttpHelper.get("transaction/getCategory"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisExtent: 60.0,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data?[index];
                          return ChoiceButton(
                            text: item['category'],
                            selected: _selectedCategory == item['id'],
                            onSelected: (_) {
                              setState(() {
                                _selectedCategory = item['id'];
                              });
                            },
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                Text(
                  "Type",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                FutureBuilder(
                  future: KAppHttpHelper.get("transaction/getType"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisExtent: 60.0,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data?[index];
                          return ChoiceButton(
                            text: item['type'],
                            selected: _selectedType == item['id'],
                            onSelected: (_) {
                              setState(() {
                                _selectedType = item['id'];
                              });
                            },
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: TextButton(
              onPressed: () {
                if (memberId == null ||
                    receiverName == null ||
                    receiverAccountId == null ||
                    receiverBankCode == null ||
                    senderName == null ||
                    senderAccountId == null ||
                    senderBankCode == null ||
                    amount == null ||
                    currency == null ||
                    uploadDate == null ||
                    uploadTime == null ||
                    _selectedCategory == null ||
                    _selectedType == null) {
                  Fluttertoast.showToast(
                    msg: 'Invalid data!',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    fontSize: 16.0,
                  );
                } else {
                  Map<String, dynamic> requestBody = {
                    'memberId': memberId,
                    'receiverName': receiverName,
                    'receiverAccountId': receiverAccountId,
                    'receiverBankCode': receiverBankCode,
                    'senderName': senderName,
                    'senderAccountId': senderAccountId,
                    'senderBankCode': senderBankCode,
                    'amount': amount,
                    'currency': currency,
                    'uploadDate': uploadDate,
                    'uploadTime': uploadTime,
                    'transactionCategoryId': _selectedCategory,
                    'transactionTypeId': _selectedType,
                  };

                  KAppHttpHelper.post("transaction/add", requestBody)
                      .then((value) => print(value));

                  Fluttertoast.showToast(
                    msg: "Successfully added!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Colors.grey.shade100.withOpacity(0.7),
                    textColor: Colors.black,
                    fontSize: 16.0,
                  );

                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: const Navigation(),
                        type: PageTransitionType.rightToLeft,
                      ));
                }
              },
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  "Submit",
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
