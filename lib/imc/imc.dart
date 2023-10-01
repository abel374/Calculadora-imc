import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ui/button_rounded.dart';
import '../ui/text_with_tap.dart';
import 'drawer.dart';
import 'opcoes.dart';
import 'text.dart';
import 'package:nb_utils/nb_utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _resultText = "Informe os seus dados: ";
  String _considerado = "";
  String imageum = "";
  String imagedois = "";
  String imagetres = "";

  void _resetFieds() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _resultText = "Informe os seus dados: ";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 9.1) {
        //
        _resultText = "abaixo do recomendado (${imc.toStringAsPrecision(3)})";
        imageum = "images/leve.png";
      } else if (imc < 18.5) {
        _resultText = "abaixo do recomendado (${imc.toStringAsPrecision(3)})";
        _considerado = "abaixo do recomendado";
        imageum = "images/leve.png";
      } else if (imc < 24.9) {
        _resultText = "Peso ideal (${imc.toStringAsPrecision(3)})";
        _considerado = "Peso ideal";
        imageum = "images/leve.png";
      } else if (imc < 29.9) {
        _resultText = "acima do recomendado (${imc.toStringAsPrecision(3)})";
        _considerado = "Levemente Acima do Peso";
        imageum = "images/normal.jpg";
      } else if (imc > 22.4) {
        _resultText = "Obesidade Grau  (${imc.toStringAsPrecision(3)}";
        _considerado = "Obesidade Grau";
        imageum = "images/obeso.png";
      } else if (imc < 34.9) {
        _resultText = "Obesidade Grau 1 (${imc.toStringAsPrecision(3)})";
        _considerado = "Obesidade Grau 1";
        imageum = "images/obeso.png";
      } else if (imc < 39.9) {
        _resultText = "Obesidade Grau 2 (${imc.toStringAsPrecision(3)})";
        _considerado = "Obesidade Grau 2";
        imageum = "images/obeso.png";
      } else {
        _resultText = "Obesidade Grau 3 (${imc.toStringAsPrecision(3)})";
        _considerado = "Obesidade Grau 3";
        imageum = "images/obeso.png";
      }
    });
  }

  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '';
  final uri = Uri.parse("http://systecango.ueuo.com/");

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _launchInWebViewOrVC(Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $uri');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        elevation: .0,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: _resetFieds, icon: const Icon(CupertinoIcons.refresh)),
          IconButton(
              onPressed: () => Get.to(DemoMWExpansionPanelScreen2()),
              icon: const Icon(CupertinoIcons.app_badge_fill)),
        ],
      ),

      //drawer: DemoMWDrawerScreen2(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(CupertinoIcons.person,
                  size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Peso em (Kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira o seu Peso!";
                  }
                },
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Altura em (cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira a tua Altura!";
                    }
                  }),
              ButtonRounded(
                text: 'Calcular',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _calculate();
                    mConercerBottomSheet(context);
                  }
                },
                color: Colors.green,
                marginTop: 10.0,
                marginBottom: 10.0,
                height: 46.0,
                borderRadius: 12.0,
                fontSize: 20.0,
              ),
              const TextWithTap(
                intervalo,
                textAlign: TextAlign.center,
                color: Colors.green,
                fontSize: 14.0,
              ),
              getCard4(),
            ],
          ),
        ),
      ),
    );
  }

  mConercerBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (builder) {
          return Container(
            height: 350.0,
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* Text(
                    _resultText,
                  ),*/

                  TextWithTap(
                    "$seuIMC${_resultText}kg/m2",
                    textAlign: TextAlign.center,
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w900,
                  ),
                  const Divider(height: 5, color: Colors.grey),
                  TextWithTap(
                    """De acordo com a Organização Mundial da Saúde, seu IMC é considerado $_considerado para a sua altura. Para manter o valor de IMC normal, seu peso pode variar entre 53.5 e 72 kg. """,
                    textAlign: TextAlign.justify,
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(imageum),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget getCard4() {
    return Container(
      height: 210,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              color: context.cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.wine_bar_outlined, color: Colors.green, size: 40),
                8.height,
                TextWithTap('Calculadora de IMC (e peso ideal)',
                  fontSize:size: 18,
                  marginButton:8.0
                  ),
               
                GestureDetector(
                  onTap: () => _makePhoneCall("+244 947875307"),
                  child: TextIcon(
                    edgeInsets:
                        EdgeInsets.only(left: 0, right: 8, bottom: 4, top: 4),
                    prefix: Icon(Icons.call, size: 14),
                    text: "+244 947875307",
                    textStyle:TextStyle(size: 14),
                  ),
                ),
                GestureDetector(
                  onTap: () => _launchInWebViewOrVC(uri),
                  child: TextIcon(
                    edgeInsets:
                        EdgeInsets.only(left: 0, right: 8, bottom: 4, top: 4),
                    prefix: Icon(Icons.web, size: 14),
                    text: "WWW.SYSTECANGO.UEUO.COM",
                    textStyle: TextStyle(size: 14),
                  ),
                ),
                TextIcon(
                  edgeInsets:
                      EdgeInsets.only(left: 0, right: 8, bottom: 4, top: 4),
                  prefix: Icon(Icons.location_on_outlined, size: 14),
                  text: "LUANDA ANGOLA ",
                  textStyle: TextStyle(size: 14),
                ),
              ],
            ),
          ).expand(),
          Container(
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
