import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Fix a list of products
class ProductInfo {
  final String name;
  final int price;

  ProductInfo(this.name, this.price);
}

final List<ProductInfo> products = [
  ProductInfo('Wireless Mouse', 1000000),
  ProductInfo('Keyboard', 2000000),
  ProductInfo('Camera', 3000000),
  ProductInfo('Speaker', 4000000),
  ProductInfo('Case PC', 5000000),
  ProductInfo('Iphone', 6000000),
  ProductInfo('Ipad', 7000000),
  ProductInfo('Mac mini', 8000000),
  ProductInfo('Mac Pro', 9000000),
  ProductInfo('Mac Studio', 10000000),
];

const String inCorrectPriceSVG = 'assets/icons/Incorrect.svg';
const String correctPriceSVG = 'assets/icons/Correct.svg';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isChecked = false;
  bool showResult = false;
  final myController = TextEditingController();
  int _currentProductIndex = 0;
  int _currentProductPrice = products[0].price;
  int _currentProductPriceInput = 0;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(products[_currentProductIndex].name),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Card(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: myController,
                          onChanged: (text) {
                            setState(() {
                              _currentProductPriceInput = text
                                      .replaceAll('.', '')
                                      .replaceAll('đ', '')
                                      .isEmpty
                                  ? 0
                                  : int.parse(text
                                      .replaceAll('.', '')
                                      .replaceAll('đ', ''));
                            });
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Price',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            CurrencyTextInputFormatter(
                              locale: 'vi_VN',
                              symbol: 'đ',
                              decimalDigits: 0,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 20, 0),
                        child: ButtonBar(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (_currentProductIndex <
                                      products.length - 1) {
                                    _currentProductIndex++;
                                    myController.clear();
                                    setState(() {
                                      _currentProductPrice =
                                          products[_currentProductIndex - 1]
                                              .price;
                                    });
                                  } else {
                                    _currentProductIndex = 0;
                                    myController.clear();
                                    setState(() {
                                      _currentProductPrice =
                                          products[_currentProductIndex].price;
                                    });
                                  }
                                  showResult = true;
                                  _currentProductPrice.compareTo(
                                              _currentProductPriceInput) ==
                                          0
                                      ? isChecked = true
                                      : isChecked = false;
                                });
                              },
                              style: (ElevatedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                              child: const Text('Check'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                myController.clear();
                                setState(() {
                                  if (_currentProductIndex == 0) {
                                    _currentProductIndex = 0;
                                  } else {
                                    _currentProductIndex--;
                                  }
                                  isChecked = false;
                                  showResult = false;
                                });
                              },
                              style: (ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                              child: const Text('Clear All'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: showResult,
              child: Center(
                child: Card(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            child: Align(
                              child: SvgPicture.asset(
                                width: 40,
                                height: 40,
                                isChecked ? correctPriceSVG : inCorrectPriceSVG,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
