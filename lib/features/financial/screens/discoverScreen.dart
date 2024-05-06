import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:kradadtod/common/widgets/carousel/bannerCarousel.dart';
import 'package:kradadtod/common/widgets/components/qrScanner.dart';
import 'package:kradadtod/common/widgets/components/searchBox.dart';
import 'package:kradadtod/common/widgets/components/transactionContainer.dart';
import 'package:kradadtod/utils/constants/colors.dart';
import 'package:kradadtod/utils/constants/sizes.dart';
import 'package:kradadtod/utils/formatters/formatters.dart';
import 'package:kradadtod/utils/helpers/functions.dart';
import 'package:kradadtod/utils/http/httpClient.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../common/widgets/appBar/commonAppBar.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  Future<dynamic>? _futureData;
  Future<dynamic>? _userData;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _futureData = KAppHttpHelper.get("transaction/getAllByMemberId?id=1");
    _checkIsLoggedIn();
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {
        _futureData = KAppHttpHelper.get("transaction/getAllByMemberId?id=1");
        _checkIsLoggedIn();
      });
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _checkIsLoggedIn();
    _refreshController.loadComplete();
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    "@" + response["username"],
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  )
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              FunctionHelpers.navigateTo(
                                  context, const QRScanner());
                            },
                            icon: const Icon(FluentIcons.add_circle_32_regular),
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(FluentIcons.add_circle_32_regular),
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
              const SearchBox(),
              const SizedBox(
                height: KAppSizes.spaceBetweenItems,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: KAppSizes.xl),
                child: Text(
                  "Discover",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: KAppSizes.md),
                  child: BannerCarousel(
                    banners: [
                      "assets/images/banners/financial_banner_1.jpg",
                      "assets/images/banners/financial_banner_2.jpg",
                      "assets/images/banners/financial_banner_3.jpg"
                    ],
                  )),
              const SizedBox(
                height: KAppSizes.spaceBetweenSections,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: KAppSizes.xl),
                child: Text(
                  "Recent Activity",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: KAppSizes.sm, vertical: KAppSizes.sm),
                child: FutureBuilder(
                  future: _futureData,
                  builder: (context, snapshot) {
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
                            accountName: KAppFormatters.capitalizeWords(name),
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
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
