import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/palette.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';

class WalletRecipient extends StatelessWidget {
  const WalletRecipient(
      {super.key,
      required this.setValues,
      required this.setOtherPayoutAccount,
      required this.currency,
      required this.recipients,
      required this.otherPayoutAccount});

  final Function setValues;
  final Function setOtherPayoutAccount;
  final String currency;
  final List<Map<String, dynamic>> recipients;
  final Map<String, dynamic> otherPayoutAccount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: () {
            setValues(1, "");
            setOtherPayoutAccount({"currency": currency});
          },
          child: Container(
              decoration: BoxDecoration(
                color: Palette.get("background.paper"),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Helpers.fetchIcons("plus-small", "solid", size: 24.0),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Widgets.buildText("Pay someone new", context,
                            weight: 500, size: 14.0),
                        Widgets.buildText(
                            "Create and pay a new  recipient", context,
                            weight: 500, size: 11.0, color: "text.secondary"),
                      ],
                    )
                  ]),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Helpers.fetchIcons("caret-right", "solid", size: 24.0)
                ],
              )),
        ),
        const SizedBox(height: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.buildText("Recipients", context, isMedium: true),
            const SizedBox(height: 20.0),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final recipient = recipients[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setOtherPayoutAccount({
                          "bank": {
                            "code": recipient["bankCode"],
                            "name": recipient["bankName"],
                          },
                          "accountNumber": recipient["accountNumber"],
                          "accountName": recipient["accountName"],
                          "currency": recipient["currency"],
                          "sortCode": recipient["sortCode"],
                          "routingNumber": recipient["routingNumber"],
                        });
                        setValues(0, recipient["code"]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Palette.get("background.paper"),
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Helpers.getPhoto(recipient["photo"].toString(),
                                    height: 30.0),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Widgets.buildText(
                                        recipient["accountName"].toString(),
                                        context,
                                        weight: 500,
                                        size: 13.0),
                                    const SizedBox(
                                      height: 1.0,
                                    ),
                                    Widgets.buildText(
                                        "${recipient["bankName"].toString()} - ${recipient["accountNumber"].toString()}",
                                        context,
                                        weight: 500,
                                        size: 13.0,
                                        color: "text.secondary"),
                                  ],
                                )
                              ],
                            ),
                            Helpers.fetchIcons("menu-dots-vertical", "solid",
                                size: 16.0)
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: recipients.length)
          ],
        )
      ],
    );
  }
}
