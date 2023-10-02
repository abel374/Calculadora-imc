import 'package:nb_utils/nb_utils.dart'; //https://pub.dev/packages/nb_utils
import 'package:flutter/material.dart';

import '../ui/text_with_tap.dart';
import 'text.dart';

class DemoMWExpansionPanelScreen2 extends StatefulWidget {
  const DemoMWExpansionPanelScreen2({Key? key}) : super(key: key);

  @override
  _DemoMWExpansionPanelScreen2State createState() =>
      _DemoMWExpansionPanelScreen2State();
}

class _DemoMWExpansionPanelScreen2State
    extends State<DemoMWExpansionPanelScreen2> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWithTap(
          "Informações sobre  IMC",
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: .0,
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 30, top: 26),
        physics: const BouncingScrollPhysics(),
        itemCount: listTitulo.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: boxDecorationDefault(
                borderRadius: radius(32), color: context.cardColor),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                backgroundColor: context.cardColor,
                title: Text(
                  listTitulo[index],
                  // 'Item ${index + 1}',
                  style: primaryTextStyle(),
                ),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/systecango.jpg'),
                  radius: 20,
                ),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                childrenPadding:
                    const EdgeInsets.only(left: 32, top: 16, bottom: 16),
                collapsedIconColor: context.iconColor,
                iconColor: context.iconColor,
                children: [
                  /*
                  Text.rich(
                    TextSpan(
                      text: 'Id :',
                      style: primaryTextStyle(),
                      children: <InlineSpan>[
                        TextSpan(text: ' 12786', style: secondaryTextStyle()),
                      ],
                    ),
                  ),
                  2.height,
                  Text.rich(
                    TextSpan(
                      text: 'Due Date :',
                      style: primaryTextStyle(),
                      children: <InlineSpan>[
                        TextSpan(
                            text: ' Expired',
                            style: secondaryTextStyle(color: Colors.redAccent)),
                      ],
                    ),
                  ),
                  2.height,
                  Text.rich(
                    TextSpan(
                      text: 'Originator : ',
                      style: primaryTextStyle(),
                      children: <InlineSpan>[
                        TextSpan(
                            text: ' Zac Efron', style: secondaryTextStyle()),
                      ],
                    ),
                  ),
                  2.height,
                  Text.rich(
                    TextSpan(
                      text: 'Start Date : ',
                      style: primaryTextStyle(),
                      children: <InlineSpan>[
                        TextSpan(
                            text: ' February 20,2019 at 7:05 PM ',
                            style: secondaryTextStyle()),
                      ],
                    ),
                  ),
                  2.height,
                  Text.rich(
                    TextSpan(
                      text: 'Current Step : ',
                      style: primaryTextStyle(),
                      children: <InlineSpan>[
                        TextSpan(text: ' 2 of 3 ', style: secondaryTextStyle()),
                      ],
                    ),
                  ),*/
                  TextWithTap(
                    respostas[index],
                    textAlign: TextAlign.justify,
                    fontSize: 15,
                    marginRight: 12.9,
                  ),
                  2.height,
                  const Divider(
                    endIndent: 32,
                    color: Colors.black54,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Startup : ',
                      style: primaryTextStyle(),
                      children: <InlineSpan>[
                        TextSpan(
                            text: ' Systec-Ango', style: secondaryTextStyle()),
                      ],
                    ),
                  ),
                  2.height,
                  Text.rich(
                    TextSpan(
                      text: 'Fonte: ',
                      style: primaryTextStyle(),
                      children: <InlineSpan>[
                        TextSpan(
                            text:
                                '  OMS ( Organização Mundial da Saúde ). Última consulta em 29-09-2023.',
                            style: secondaryTextStyle()),
                      ],
                    ),
                  ),
                  4.height,
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.all(4),
                        decoration: boxDecorationDefault(
                            border: Border.all(color: Colors.black26)),
                        child: const Icon(
                          Icons.sports_handball,
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.all(4),
                        decoration: boxDecorationDefault(
                            border: Border.all(color: Colors.black26)),
                        child: const Icon(
                          Icons.apartment_outlined,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
