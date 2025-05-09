import 'package:cribsfinder/utils/helpers.dart';
import 'package:cribsfinder/utils/modals.dart';
import 'package:cribsfinder/utils/palette.dart';
import 'package:cribsfinder/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletAddRecipient extends StatelessWidget {
  const WalletAddRecipient(
      {super.key,
      required this.setOtherPayoutAccount,
      required this.account,
      required this.banks,
      required this.otherPayoutAccount,
      required this.accountNumberController,
      required this.bankController,
      required this.sortCodeController,
      required this.routingNumberController,
      required this.accountNameController});

  final Function setOtherPayoutAccount;
  final String account;
  final List<Map<String, dynamic>> banks;
  final Map<String, dynamic> otherPayoutAccount;

  final TextEditingController accountNumberController;
  final TextEditingController bankController;
  final TextEditingController sortCodeController;
  final TextEditingController routingNumberController;
  final TextEditingController accountNameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Widgets.buildText("Recipient Account", context, isMedium: true),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: Palette.getColor(context, "background", "paper"),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Column(
                  children: [
                    TextFormField(
                      controller: accountNumberController,
                      readOnly: account.isNotEmpty,
                      decoration: Widgets.inputDecoration("",
                          hint: "Enter your account number",
                          hintColor: Palette.get("text.other"),
                          isOutline: true,
                          borderColor: Colors.transparent,
                          isFloating: true,
                          color: Palette.getColor(context, "text", "other")),
                      onChanged: (text) {
                        setOtherPayoutAccount(
                            {"accountNumber": text, "accountName": ""});
                      },
                      style: GoogleFonts.nunito(
                          color: Palette.getColor(context, "text", "other")),
                    ),
                    Divider(thickness: 1.0, color: Color(0x14000000)),
                    if (otherPayoutAccount["currency"] == "NGN")
                      TextFormField(
                        readOnly: true,
                        controller: bankController,
                        decoration: Widgets.inputDecoration("",
                            hint: "Select Bank",
                            hintColor: Palette.get("text.other"),
                            suffixIcon: account.isEmpty
                                ? UnconstrainedBox(
                                    child: Helpers.fetchIcons(
                                        "caret-right", "solid",
                                        size: 16.0),
                                  )
                                : null,
                            isOutline: true,
                            borderColor: Colors.transparent,
                            isFloating: true,
                            color: Palette.getColor(context, "text", "other")),
                        onTap: () async {
                          if (account.isNotEmpty) {
                            return;
                          }
                          final res = await Sheets.showSortBy("",
                              items: banks,
                              title: "Select a Bank",
                              isShowClear: false,
                              isShowIcon: true);
                          if (res.isNotEmpty) {
                            final selectedBank =
                                banks[num.tryParse(res)?.toInt() ?? 0];
                            bankController.text = selectedBank["name"];
                            setOtherPayoutAccount({
                              "bank": {
                                "name": selectedBank["name"],
                                "code": selectedBank["code"]
                              }
                            });
                          }
                        },
                        style: GoogleFonts.nunito(
                            color: Palette.getColor(context, "text", "other")),
                      ),
                    if (otherPayoutAccount["currency"] == "USD")
                      TextFormField(
                          controller: routingNumberController,
                          readOnly: account.isNotEmpty,
                          decoration: Widgets.inputDecoration("",
                              hint: "Enter your bank routing number",
                              hintColor: Palette.get("text.other"),
                              isOutline: true,
                              borderColor: Colors.transparent,
                              isFloating: true,
                              color:
                                  Palette.getColor(context, "text", "other")),
                          style: GoogleFonts.nunito(
                              color:
                                  Palette.getColor(context, "text", "other")),
                          onChanged: (text) {
                            setOtherPayoutAccount(
                                {"routingNumber": text, "accountName": ""});
                          }),
                    if (otherPayoutAccount["currency"] == "GBP")
                      TextFormField(
                          controller: sortCodeController,
                          readOnly: account.isNotEmpty,
                          decoration: Widgets.inputDecoration("",
                              hint: "Enter your bank sort code",
                              hintColor: Palette.get("text.other"),
                              isOutline: true,
                              borderColor: Colors.transparent,
                              isFloating: true,
                              color:
                                  Palette.getColor(context, "text", "other")),
                          style: GoogleFonts.nunito(
                              color:
                                  Palette.getColor(context, "text", "other")),
                          onChanged: (text) {
                            setOtherPayoutAccount(
                                {"sortCode": text, "accountName": ""});
                          }),
                    Divider(thickness: 1.0, color: Color(0x14000000)),
                    TextFormField(
                        controller: accountNameController,
                        readOnly: otherPayoutAccount["currency"] == "NGN" ||
                            account.isNotEmpty,
                        decoration: Widgets.inputDecoration("",
                            hint: "Account Name",
                            hintColor: Palette.get("text.other"),
                            isOutline: true,
                            borderColor: Colors.transparent,
                            isFloating: true,
                            color: Palette.getColor(context, "text", "other")),
                        style: GoogleFonts.nunito(
                            color: Palette.getColor(context, "text", "other")),
                        onChanged: (text) {
                          setOtherPayoutAccount({"accountName": text});
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
        // if (account.isNotEmpty)
        //   Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const SizedBox(height: 20.0),
        //       Widgets.buildText("Amount", context, weight: 500, size: 14.0),
        //       const SizedBox(height: 10.0),
        //       Container(
        //         decoration: BoxDecoration(
        //           color: Palette.getColor(context, "background", "paper"),
        //           borderRadius: BorderRadius.circular(20.0),
        //         ),
        //         padding: const EdgeInsets.symmetric(
        //             horizontal: 20.0, vertical: 10.0),
        //         child: TextFormField(
        //             controller: amountController,
        //             readOnly: amount.isNotEmpty,
        //             decoration: Widgets.inputDecoration("",
        //                 hint: "Amount to send",
        //                 hintColor: Palette.get("text.other"),
        //                 isOutline: true,
        //                 borderColor: Colors.transparent,
        //                 isFloating: true,
        //                 color: Palette.getColor(context, "text", "other")),
        //             style: GoogleFonts.nunito(
        //                 color: Palette.getColor(context, "text", "other")),
        //             keyboardType: TextInputType.number,
        //             onChanged: (text) {
        //               setState(() {
        //                 result["amount"] = text;
        //               });
        //             }),
        //       ),
        //       const SizedBox(height: 20.0),
        //       Widgets.buildText("Reference", context, weight: 500, size: 13.0),
        //       Container(
        //         decoration: BoxDecoration(
        //           color: Palette.getColor(context, "background", "paper"),
        //           borderRadius: BorderRadius.circular(20.0),
        //         ),
        //         padding: const EdgeInsets.symmetric(
        //             horizontal: 20.0, vertical: 10.0),
        //         child: TextFormField(
        //             controller: noteController,
        //             decoration: Widgets.inputDecoration("",
        //                 hint: "What is this for? (optional)",
        //                 hintColor: Palette.get("text.other"),
        //                 isOutline: true,
        //                 borderColor: Colors.transparent,
        //                 isFloating: true,
        //                 color: Palette.getColor(context, "text", "other")),
        //             style: GoogleFonts.nunito(
        //                 color: Palette.getColor(context, "text", "other")),
        //             onChanged: (text) {
        //               setState(() {
        //                 result["note"] = text;
        //               });
        //             }),
        //       ),
        //       const SizedBox(height: 20.0),
        //       SizedBox(
        //           width: double.infinity,
        //           child: TextButton(
        //               onPressed: () async {
        //                 if (result.isEmpty ||
        //                     result["amount"].toString().isEmpty) {
        //                   Alert.show(context, "",
        //                       "Please set a valid amount to proceed.",
        //                       type: "warning");
        //                   return;
        //                 } else {
        //                   final res = await Sheets.showVerifyTransfer(
        //                       account,
        //                       balance,
        //                       currency,
        //                       result["amount"].toString(),
        //                       withdrawFee);
        //                   if (res) {
        //                     setState(() => result["amount"] =
        //                         amountController.numberValue.toString());
        //                     Navigator.pop(context);
        //                   }
        //                 }
        //               },
        //               style: Widgets.buildButton(context,
        //                   radius: 50.0,
        //                   background: Palette.get("main.primary"),
        //                   vertical: 15.0),
        //               child: Widgets.buildText("Confirm", context,
        //                   color: "text.white", isMedium: true)))
        //     ],
        //   )
      ],
    );
  }
}
