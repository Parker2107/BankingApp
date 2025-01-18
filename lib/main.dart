// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
  
void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return ChangeNotifierProvider
    (
      create: (context) => MyAppState(),
      child: MaterialApp
      (
        title: 'Banking App',
        theme: ThemeData
        (
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
        ),
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyAppState extends ChangeNotifier
{

}

class MyHomePage extends StatefulWidget
{
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    LoanInterestCalculator(),
    const CurrencyExchange(),
    const BankAddress(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
          final isWideScreen = constraints.maxWidth > 765;
          final isKindaWide = constraints.maxWidth > 400;
          final iconWidth = isWideScreen ? 30.0 : isKindaWide ? 25.0 : 22.0;
          final paddingScale = isKindaWide ? 1.0 : 0.5;
          final fontSizing = isKindaWide ? 15.0 : 11.0;
          final widthNav = isWideScreen ? 100.0 : isKindaWide ? 80.0 : 60.0;
        return Scaffold(
          /*appBar: AppBar(
            automaticallyImplyLeading: true,
            leadingWidth: 90,
            leading: Icon(size: 50,color: Color.fromRGBO(0, 140, 255, 1), AntDesign.bank_fill),
            toolbarHeight: 70,
            title: Center(child: Text(style: GoogleFonts.blackOpsOne(textStyle: TextStyle(fontSize: 50,color: Colors.amber)),"The Banking App")),
            backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
          ),*/
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  leading: Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,30),
                    child: Icon(size: iconWidth*2,color: Color.fromRGBO(0, 140, 255, 1), AntDesign.bank_fill),
                  ),
                  backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(size: iconWidth,Icons.home), 
                      label: Padding(
                        padding: EdgeInsets.fromLTRB(0,5,0,5) * paddingScale,
                        child: Center(child: Text('Home', style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: fontSizing)))),
                      )
                    ),
                    NavigationRailDestination(
                      icon: Icon(size: iconWidth,Icons.currency_exchange),
                      label: Padding(
                        padding: EdgeInsets.fromLTRB(0,5,0,5),
                        child: Center(child: Text(textAlign: TextAlign.center ,"Currency \nExchange",style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: fontSizing)))),
                      )
                    ),
                    NavigationRailDestination(
                      icon: Icon(size: iconWidth,Clarity.map_solid_badged),
                      label: Padding(
                        padding: EdgeInsets.fromLTRB(0,5,0,5) * paddingScale,
                        child: Center(child: Text(textAlign: TextAlign.center, "Banks \nNear Me",style: GoogleFonts.lexend(textStyle: TextStyle(fontSize: fontSizing)))),
                      )
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  selectedLabelTextStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1),),
                  selectedIconTheme: const IconThemeData(fill: 1, color: Color.fromRGBO(35, 35, 35, 1)),
                  unselectedLabelTextStyle: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1),),
                  unselectedIconTheme: const IconThemeData(fill: 0, color:Color.fromRGBO(0, 140, 255, 1)),
                  useIndicator: true,
                  //indicatorColor: const Color(0xFFEEEEEE),
                  indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20)),side: BorderSide(width: 3.0,color: Color(0xFFEEEEEE))),
                  minWidth: widthNav,
                  elevation: 20,
                ),
              ),
              Expanded(
                child: Container(
                  color: const Color.fromRGBO(163, 162, 162, 1),
                  child: pages[selectedIndex],
                )
              ),
            ], // Children
          ),
        );
      }
    );
  }
}

class BankAddress extends StatelessWidget {
  const BankAddress({super.key});

  // List of fake bank addresses
  final List<Map<String, String>> bankAddresses = const [
    {'name': 'Bank of Flutter', 'address': '123 Flutter St, Dart City'},
    {'name': 'Dart Savings', 'address': '456 Widget Rd, Codeville'},
    {'name': 'Stateless Bank', 'address': '789 State Ln, UI Town'},
    {'name': 'Build Trust Bank', 'address': '101 Build Blvd, Tree Grove'},
    {'name': 'Key Bank', 'address': '202 Key Crescent, Flutterburg'},
    {'name' : 'HDFC Bank', 'address' : '405 King\'s road, Vellore, TN'}
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        final isWideScreen = constraints.maxWidth > 765;
          final isKindaWide = constraints.maxWidth > 400;
          final textScale = isWideScreen ? 1.5 : 1.0;
          final paddingScale = isWideScreen ? 20.0 : isKindaWide ? 10.00 : 5.00;
        return Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/img1.png"),fit: BoxFit.cover,),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(paddingScale),
                //child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.06),
                      Text(
                        'Banks Near Me',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.blackOpsOne(
                          textStyle: TextStyle(
                            color: Colors.amber,
                            fontSize: 40 * textScale,
                            textBaseline: TextBaseline.alphabetic,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.08), 
                      SizedBox(
                        width: 750,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: bankAddresses.length,
                          itemBuilder: (context, index) {
                            final bank = bankAddresses[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                              child: ListTile(
                                enabled: true,
                                selectedColor: Colors.blue,
                                hoverColor: Colors.grey,
                                leading: CircleAvatar(
                                  backgroundColor: const Color.fromRGBO(0, 77, 153, 1),
                                  child: const Icon(
                                    Icons.account_balance,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  bank['name']!,
                                  style: GoogleFonts.lexend(
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  bank['address']!,
                                  style: GoogleFonts.lexend(
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          //),
        );
      }
    );
  }
}


class Currency {
  final String symbol;
  final String name;
  final String symbolNative;
  final int decimalDigits;
  final int rounding;
  final String code;
  final String namePlural;
  final String type;
  final List<String> countries;

  Currency({
    required this.symbol,
    required this.name,
    required this.symbolNative,
    required this.decimalDigits,
    required this.rounding,
    required this.code,
    required this.namePlural,
    required this.type,
    required this.countries,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      symbol: json['symbol'],
      name: json['name'],
      symbolNative: json['symbol_native'],
      decimalDigits: json['decimal_digits'],
      rounding: json['rounding'],
      code: json['code'],
      namePlural: json['name_plural'],
      type: json['type'],
      countries: List<String>.from(json['countries']),
    );
  }
}
class CurrencyApiResponse {
  final String lastUpdatedAt;
  final Map<String, CurrencyData> data;

  CurrencyApiResponse({
    required this.lastUpdatedAt,
    required this.data,
  });

  factory CurrencyApiResponse.fromJson(Map<String, dynamic> json) {
    return CurrencyApiResponse(
      lastUpdatedAt: json['meta']['last_updated_at'], 
      data: (json['data'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, CurrencyData.fromJson(value)),
      ),
    );
  }
}

class ExchangeData {
  final String code;
  final double value;

  ExchangeData({
    required this.code,
    required this.value,
  });

  factory ExchangeData.fromJson(Map<String, dynamic> json) {
    return ExchangeData(
      code: json['code'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'value': value,
    };
  }
}


class CurrencyData {
  final Map<String, Currency> currencies;

  CurrencyData({required this.currencies});

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final currencies = data.map((key, value) =>
        MapEntry(key, Currency.fromJson(value as Map<String, dynamic>)));
    return CurrencyData(currencies: currencies);
  }

  Currency? getCurrency(String code) {
    return currencies[code];
  }
}

class CurrencyExchange extends StatefulWidget {
  const CurrencyExchange({
    super.key,
  });
  @override
  State<CurrencyExchange> createState() => _CurrencyExchangeState();
}

class _CurrencyExchangeState extends State<CurrencyExchange> {
  
  late Future<Map<String, Currency>> currencies; //CurrencyData
  final _formKey = GlobalKey<FormState>();
  String _currency1 = '';
  String _currency2 = '';
  final TextEditingController _money = TextEditingController();
  final TextEditingController _money2 = TextEditingController();
  final Map<String, Currency> demoCurrencies = {
  "AED": Currency(
    symbol: "د.إ",
    name: "United Arab Emirates Dirham",
    symbolNative: "د.إ",
    decimalDigits: 2,
    rounding: 0,
    code: "AED",
    namePlural: "United Arab Emirates dirhams",
    type: "fiat",
    countries: ["AE"],
  ),
  "AUD": Currency(
    symbol: "A\$",
    name: "Australian Dollar",
    symbolNative: "A\$",
    decimalDigits: 2,
    rounding: 0,
    code: "AUD",
    namePlural: "Australian dollars",
    type: "fiat",
    countries: ["AU"],
  ),
  "BRL": Currency(
    symbol: "R\$",
    name: "Brazilian Real",
    symbolNative: "R\$",
    decimalDigits: 2,
    rounding: 0,
    code: "BRL",
    namePlural: "Brazilian reals",
    type: "fiat",
    countries: ["BR"],
  ),
  "CAD": Currency(
    symbol: "CA\$",
    name: "Canadian Dollar",
    symbolNative: "CA\$",
    decimalDigits: 2,
    rounding: 0,
    code: "CAD",
    namePlural: "Canadian dollars",
    type: "fiat",
    countries: ["CA"],
  ),
  "CNY": Currency(
    symbol: "¥",
    name: "Chinese Yuan",
    symbolNative: "¥",
    decimalDigits: 2,
    rounding: 0,
    code: "CNY",
    namePlural: "Chinese yuan",
    type: "fiat",
    countries: ["CN"],
  ),
  "EUR": Currency(
    symbol: "€",
    name: "Euro",
    symbolNative: "€",
    decimalDigits: 2,
    rounding: 0,
    code: "EUR",
    namePlural: "Euros",
    type: "fiat",
    countries: ["EU"],
  ),
  "GBP": Currency(
    symbol: "£",
    name: "British Pound Sterling",
    symbolNative: "£",
    decimalDigits: 2,
    rounding: 0,
    code: "GBP",
    namePlural: "British pounds",
    type: "fiat",
    countries: ["GB"],
  ),
  "HKD": Currency(
    symbol: "HK\$",
    name: "Hong Kong Dollar",
    symbolNative: "HK\$",
    decimalDigits: 2,
    rounding: 0,
    code: "HKD",
    namePlural: "Hong Kong dollars",
    type: "fiat",
    countries: ["HK"],
  ),
  "INR": Currency(
    symbol: "₹",
    name: "Indian Rupee",
    symbolNative: "₹",
    decimalDigits: 2,
    rounding: 0,
    code: "INR",
    namePlural: "Indian rupees",
    type: "fiat",
    countries: ["IN"],
  ),
  "JPY": Currency(
    symbol: "¥",
    name: "Japanese Yen",
    symbolNative: "￥",
    decimalDigits: 0,
    rounding: 0,
    code: "JPY",
    namePlural: "Japanese yen",
    type: "fiat",
    countries: ["JP"],
  ),
  "KRW": Currency(
    symbol: "₩",
    name: "South Korean Won",
    symbolNative: "₩",
    decimalDigits: 0,
    rounding: 0,
    code: "KRW",
    namePlural: "South Korean wons",
    type: "fiat",
    countries: ["KR"],
  ),
  "MXN": Currency(
    symbol: "MX\$",
    name: "Mexican Peso",
    symbolNative: "MX\$",
    decimalDigits: 2,
    rounding: 0,
    code: "MXN",
    namePlural: "Mexican pesos",
    type: "fiat",
    countries: ["MX"],
  ),
  "NOK": Currency(
    symbol: "kr",
    name: "Norwegian Krone",
    symbolNative: "kr",
    decimalDigits: 2,
    rounding: 0,
    code: "NOK",
    namePlural: "Norwegian kroner",
    type: "fiat",
    countries: ["NO"],
  ),
  "NZD": Currency(
    symbol: "NZ\$",
    name: "New Zealand Dollar",
    symbolNative: "NZ\$",
    decimalDigits: 2,
    rounding: 0,
    code: "NZD",
    namePlural: "New Zealand dollars",
    type: "fiat",
    countries: ["NZ"],
  ),
  "RUB": Currency(
    symbol: "₽",
    name: "Russian Ruble",
    symbolNative: "₽",
    decimalDigits: 2,
    rounding: 0,
    code: "RUB",
    namePlural: "Russian rubles",
    type: "fiat",
    countries: ["RU"],
  ),
  "SAR": Currency(
    symbol: "ر.س",
    name: "Saudi Riyal",
    symbolNative: "ر.س",
    decimalDigits: 2,
    rounding: 0,
    code: "SAR",
    namePlural: "Saudi riyals",
    type: "fiat",
    countries: ["SA"],
  ),
  "SEK": Currency(
    symbol: "kr",
    name: "Swedish Krona",
    symbolNative: "kr",
    decimalDigits: 2,
    rounding: 0,
    code: "SEK",
    namePlural: "Swedish kronor",
    type: "fiat",
    countries: ["SE"],
  ),
  "SGD": Currency(
    symbol: "S\$",
    name: "Singapore Dollar",
    symbolNative: "S\$",
    decimalDigits: 2,
    rounding: 0,
    code: "SGD",
    namePlural: "Singapore dollars",
    type: "fiat",
    countries: ["SG"],
  ),
  "TRY": Currency(
    symbol: "₺",
    name: "Turkish Lira",
    symbolNative: "₺",
    decimalDigits: 2,
    rounding: 0,
    code: "TRY",
    namePlural: "Turkish liras",
    type: "fiat",
    countries: ["TR"],
  ),
  "USD": Currency(
    symbol: "\$",
    name: "US Dollar",
    symbolNative: "\$",
    decimalDigits: 2,
    rounding: 0,
    code: "USD",
    namePlural: "US dollars",
    type: "fiat",
    countries: ["US"],
  ),
  "ZAR": Currency(
    symbol: "R",
    name: "South African Rand",
    symbolNative: "R",
    decimalDigits: 2,
    rounding: 0,
    code: "ZAR",
    namePlural: "South African rands",
    type: "fiat",
    countries: ["ZA"],
  ),
};

  @override
  void initState() {
    super.initState();
    currencies = Future.value(demoCurrencies);
  }

  void convertMoney() async {
    String c2 = _currency1;
    String c1 = _currency2;
    double m1 = double.parse(_money.text);
    String api = 'https://api.currencyapi.com/v3/latest?apikey=cur_live_F0zNEZAIs7s9VMtRdpr3FFxmkVaNIm6hIkArLkiP&base_currency=';
    String currency = '&currencies=';
    String finalAPI = '$api$c2$currency$c1';
    final response = await http.get(Uri.parse(finalAPI));

    if (response.statusCode!= 200)
    {
      throw Exception('Failed to get exchange rate');
    }
    final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    final exchangeRate = jsonResponse['data'][c1]['value'];
    double m2 = m1*exchangeRate;
    print("Selected Money is $m2");
    setState(() {
      _money2.text = m2.toStringAsFixed(2);
    });
  }
  
  /*Future<CurrencyData> fetchCurrencies() async {
    final response = await http.get(Uri.parse(
        'https://api.currencyapi.com/v3/currencies?apikey=cur_live_F0zNEZAIs7s9VMtRdpr3FFxmkVaNIm6hIkArLkiP'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return CurrencyData.fromJson(jsonResponse);
    }
    else {
      throw Exception('Failed to load currencies');
    }
  }*/

  @override
  Widget build(BuildContext context) { //this is the start of a function
      return LayoutBuilder(
        builder: (context,constraints) {
          final isWideScreen = constraints.maxWidth > 765;
          final isKindaWide = constraints.maxWidth > 400;
          final textScale = isWideScreen ? 1.5 : 1.0;
          final paddingScale = isWideScreen ? 10.0 : isKindaWide ? 5.00 : 0.00;
          final textFieldScale = isWideScreen ? 0.45 : isKindaWide ? 0.55 : 0.67;
          final currencyField = 140.00;//isWideScreen ? 150.00 : isKindaWide ? 130.00 : 120.00;
          return Scaffold(
            body: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/img1.png"),fit: BoxFit.cover,),
              ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(paddingScale),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: constraints.maxHeight * 0.06),
                          Text(
                            'Currency Exchange \nCalculator',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.blackOpsOne(
                              textStyle: TextStyle(
                                color: Colors.amber,
                                fontSize: 40 * textScale,
                                textBaseline: TextBaseline.alphabetic,
                              ),
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.08), 
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      width: currencyField,
                                      child: FutureBuilder<Map<String, Currency>>( //CurrencyData
                                        future: currencies,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Center(child: CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                'Error: ${snapshot.error}',
                                                style: TextStyle(color: Colors.red),
                                              ),
                                            );
                                          } else if (snapshot.hasData) {
                                            final currencies = demoCurrencies; // snapshot.data!.currencies;
                                            return DropdownButtonFormField<String>(
                                              //icon: Icon(Icons.currency_exchange),
                                              decoration: InputDecoration(
                                                filled: true,
                                                border: OutlineInputBorder(),
                                              ),
                                              items: currencies.entries.map((entry) {
                                                final symbol = entry.value.symbol;
                                                final code = entry.key;
                                                return DropdownMenuItem(
                                                  value: code,
                                                  child: Text('$code ($symbol)'),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _currency1 = value.toString();
                                                });
                                                print('Selected currency: $value');
                                              },
                                            );
                                          } else {
                                            return Center(child: Text('No data available.'));
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      width: constraints.maxWidth * textFieldScale,
                                      child: TextField(
                                        controller: _money,
                                        decoration: InputDecoration(
                                          filled: true,
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter Money Here',
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Icon(
                                  size: 40,
                                  color: Colors.white,
                                  AntDesign.swap_outline,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      width: currencyField,
                                      child: FutureBuilder<Map<String, Currency>>(
                                        future: currencies,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Center(child: CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                'Error: ${snapshot.error}',
                                                style: TextStyle(color: Colors.red),
                                              ),
                                            );
                                          } else if (snapshot.hasData) {
                                            final currencies = demoCurrencies; // snapshot.data!.currencies;
                                            return DropdownButtonFormField<String>(
                                              //icon: Icon(Icons.currency_exchange),
                                              decoration: InputDecoration(
                                                filled: true,
                                                border: OutlineInputBorder(),
                                              ),
                                              items: currencies.entries.map((entry) {
                                                final symbol = entry.value.symbol;
                                                final code = entry.key;
                                                return DropdownMenuItem(
                                                  value: code,
                                                  child: Text('$code ($symbol)'),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _currency2=value.toString();
                                                });
                                                print('Selected currency: $value');
                                              },
                                            );
                                          } else {
                                            return Center(child: Text('No data available.'));
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10), // Add spacing
                                    SizedBox(
                                      width: constraints.maxWidth * textFieldScale,
                                      child: TextField(
                                        controller: _money2,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          filled: true,
                                          border: OutlineInputBorder(),
                                          label: Text('Converted Money Here'),
                                        ),
                                        keyboardType: TextInputType.number, // Restrict to numeric input
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.07),
                          Center(
                              child: ElevatedButton(
                                style: ButtonStyle(elevation: WidgetStateProperty.all(10.0),fixedSize: WidgetStatePropertyAll(Size.fromHeight(50))),
                                onPressed:() {
                                  convertMoney();
                                  print("Conversion called");
                                },
                                child: Text(style: TextStyle(fontSize: 18),'Convert Currency'),
                              ),
                            ),
                        ], // Children
                      ),
                    ),
                  ),
                ),
              )
            );
        }
      );
    }
}


class LoanInterestCalculator extends StatefulWidget {
  @override
  _LoanInterestCalculatorState createState() => _LoanInterestCalculatorState();
}

class _LoanInterestCalculatorState extends State<LoanInterestCalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _principal = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  String _result = '';

  void _calculateInterest() {
    if (_formKey.currentState!.validate()) {

      final double principal = double.parse(_principal.text);
      final double time = double.parse(_time.text);
      final double rate = double.parse(_rate.text);

      final double interest = (principal * time * rate) / 100;

      setState(() {
        _result = 'Total Interest: ₹${interest.toStringAsFixed(2)}';
      });
      _principal.clear();
      _rate.clear();
      _time.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        final isWideScreen = constraints.maxWidth > 765;
        final isKindaWide = constraints.maxWidth > 400;
        final paddingScale = isWideScreen ? 20.0 : isKindaWide ? 10.00 : 5.00;
        final textScale = isWideScreen ? 1.5 : 1.0;
        return Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/img1.png"), fit: BoxFit.cover),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(paddingScale),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: constraints.maxHeight *0.06,),
                      Text(textAlign: TextAlign.center,style: GoogleFonts.blackOpsOne(textStyle: TextStyle(color: Colors.amber,fontSize: 40 * textScale, textBaseline: TextBaseline.alphabetic)),'Loan Interest \nCalculator'),
                      SizedBox(height: constraints.maxHeight * 0.08,),
                      SizedBox(
                        width: 500,
                        child: TextField(
                          controller: _principal,
                          decoration: InputDecoration(
                            //icon: Icon(color: Colors.white,Clarity.dollar_solid), 
                            filled: true,
                            label: Text(style: TextStyle(color: Colors.grey[700]),'Enter Principal Amount'),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 500,
                        child: TextField(
                          controller: _time,
                          decoration: InputDecoration(
                            filled: true,
                            label: Text(style: TextStyle(color: Colors.grey[700]),'Enter Time (in years)'),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 500,
                        child: TextField(
                          controller: _rate,
                          decoration: InputDecoration(
                            filled: true,
                            label: Text(style: TextStyle(color: Colors.grey[700]),'Enter Rate of Interest (%)'),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight*0.06),
                      ElevatedButton(
                        style: ButtonStyle(elevation: WidgetStateProperty.all(10.0),fixedSize: WidgetStatePropertyAll(Size.fromHeight(50))),
                        onPressed: _calculateInterest,
                        child: Text(style: TextStyle(fontSize: 18),'Calculate Interest'),
                      ),
                      SizedBox(height: constraints.maxHeight*0.06),
                      if (_result.isNotEmpty)
                        FittedBox(
                          child: Text(
                            _result,
                            style: GoogleFonts.tomorrow(color: Colors.white,textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ], //Children
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}