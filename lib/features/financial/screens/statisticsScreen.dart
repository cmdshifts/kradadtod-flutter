import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:kradadtod/common/widgets/appBar/commonAppBar.dart';
import 'package:kradadtod/features/financial/screens/achievementScreen.dart';
import 'package:kradadtod/utils/devices/deviceUtility.dart';
import 'package:kradadtod/utils/formatters/formatters.dart';
import 'package:kradadtod/utils/helpers/functions.dart';
import 'package:kradadtod/utils/http/httpClient.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../common/widgets/components/qrScanner.dart';
import '../../../common/widgets/components/transactionContainer.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Future<dynamic>? _futureData;
  Future<dynamic>? _transactionData;
  Future<dynamic>? _statisticsData;
  Future<dynamic>? _userData;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _fetchData();
    _checkIsLoggedIn();
  }

  _checkIsLoggedIn() async {
    if (await FunctionHelpers.hasLoginData()) {
      final data = await FunctionHelpers.getLoginData();
      if (data['identity'] != null && data['password'] != null) {
        String id = data['identity'];
        String password = data['password'];

        final res =
            await KAppHttpHelper.get("auth?identity=$id&password=$password");
        _userData = Future.value(res);
        setState(() {});
      }
    }
  }

  Future<void> _fetchData() async {
    try {
      _futureData = KAppHttpHelper.get("achievement/getByMemberId?id=1");
      final achievementData = await _futureData;
      if (achievementData != null && achievementData.isNotEmpty) {
        final achievementTime = achievementData[0]['time'].toString();
        _transactionData = KAppHttpHelper.get(
          "transaction/getTransactionByMemberIdAndDateAfter?id=1&date=$achievementTime",
        );
        _statisticsData = KAppHttpHelper.get(
          "transaction/getStatistics?id=1&date=$achievementTime",
        );
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {
        _fetchData();
      });
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: false,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: _userData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final response = snapshot.data;
                      return CommonAppBar(
                        showBackArrow: false,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: KAppColors.azure,
                                  radius: KAppSizes.profileBorder,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/user.png'),
                                    radius: KAppSizes.profileImage,
                                  ),
                                ),
                                const SizedBox(width: KAppSizes.defaultSpace),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      response['displayName'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    Text(
                                      "@" + response["username"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  FluentIcons.service_bell_16_regular),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return CommonAppBar(
                        showBackArrow: false,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: KAppColors.azure,
                                  radius: KAppSizes.profileBorder,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/user.png'),
                                    radius: KAppSizes.profileImage,
                                  ),
                                ),
                                const SizedBox(width: KAppSizes.defaultSpace),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Please login!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                  FluentIcons.service_bell_16_regular),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: KAppSizes.spaceBetweenItems,
                ),
                Stack(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: KAppSizes.md),
                      padding: const EdgeInsets.all(KAppSizes.md),
                      width: KAppDeviceUtils.getScreenWidth(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(KAppSizes.sm),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                            future: _futureData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                final item = snapshot.data?[0];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Target",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    Text(
                                      KAppFormatters.formatMoney(
                                          item['amount']),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                    const SizedBox(
                                      height: KAppSizes.md,
                                    ),
                                    Text(
                                      "Started from",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    Text(
                                      KAppFormatters.formatDate(
                                          DateTime.parse(item['time']), null),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(
                                      height: KAppSizes.md,
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          FutureBuilder(
                            future: _statisticsData,
                            builder: (context, snapshot) {
                              Widget balance;
                              if (snapshot.hasData) {
                                if (snapshot.data['currentTotal'] >= 0) {
                                  balance = Text(
                                    KAppFormatters.formatMoney(
                                        snapshot.data['currentTotal']),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.green),
                                  );
                                } else {
                                  balance = Text(
                                    KAppFormatters.formatMoney(
                                        snapshot.data['currentTotal']),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: Colors.red),
                                  );
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    balance
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 6.0,
                      right: 20.0,
                      child: IconButton(
                        onPressed: () {
                          FunctionHelpers.navigateTo(
                              context, const AchievementScreen());
                        },
                        icon: const Icon(FluentIcons.settings_16_regular),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: KAppSizes.spaceBetweenSections,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: KAppSizes.xl),
                  child: Text(
                    "Your transaction",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: KAppSizes.sm, vertical: KAppSizes.sm),
                  child: FutureBuilder(
                    future: _transactionData,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisExtent: 75,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data?[index];
                            String type = item['type'];
                            String name;
                            String category;
                            int bankCode;
                            Widget balance;

                            if (type == "Income") {
                              name = item['senderName'];
                              category = item['category'];
                              bankCode = item['senderBankCode'];
                              balance = Text(
                                KAppFormatters.formatMoney(item['amount']),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.green),
                              );
                            } else {
                              name = item['receiverName'];
                              category = item['category'];
                              bankCode = item['receiverBankCode'];
                              balance = Text(
                                KAppFormatters.formatMoney(item['amount']),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.red),
                              );
                            }

                            return TransactionContainer(
                              accountName: name,
                              category: category,
                              balance: balance,
                              bankCode: FunctionHelpers.getBankLogo(bankCode),
                              date: KAppFormatters.formatDate(
                                  DateTime.parse(item['uploadDate']), null),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
