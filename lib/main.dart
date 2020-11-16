import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  List<Ders> tumDersler;
  static int sayac = 0;

  var formKey = GlobalKey<FormState>();
  double ortalama = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Ortalama Hesapla "),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return uygulamaGovdesi();
        } else {
          return uygulamaGovdesiLandscape();
        }
      }),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //STATIC FORMU TUTON CONTAINER
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            //color: Colors.pink.shade200,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Ders Adı",
                      hintText: "Dersin adını giriniz",
                      hintStyle: TextStyle(fontSize: 18),
                      labelStyle: TextStyle(fontSize: 22),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                    ),
                    validator: (girilenDeger) {
                      if (girilenDeger.length > 0) {
                        return null;
                      } else
                        return "Ders adı boş girilemez";
                    },
                    onSaved: (kaydedilecekDeger) {
                      dersAdi = kaydedilecekDeger;
                      setState(() {
                        tumDersler
                            .add(Ders(dersAdi, dersHarfDegeri, dersKredi));
                        ortalama = 0;
                        ortalamayiHesapla();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: dersKrediItems(),
                            value: dersKredi,
                            onChanged: (secilenKredi) {
                              setState(() {
                                dersKredi = secilenKredi;
                              });
                            },
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                              items: dersHarfDegerleriItems(),
                              value: dersHarfDegeri,
                              onChanged: (secilenHarf) {
                                setState(() {
                                  dersHarfDegeri = secilenHarf;
                                });
                              }),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          //ORTALAMA HESAPLAMA GÖSTEREN KONTEYNIRI
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 70,
            decoration: BoxDecoration(
              border: BorderDirectional(
                top: BorderSide(color: Colors.blue, width: 2),
                bottom: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: tumDersler.length == 0
                            ? "Lütfen ders ekleyin"
                            : "Ortalama : ",
                        style: TextStyle(fontSize: 30, color: Colors.black)),
                    TextSpan(
                        text: tumDersler.length == 0 ? " " : "${ortalama} ",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),

          //DİNAMİK LİSTE FORMUNU TUTAN CONTAINER
          Expanded(
            child: Container(
              color: Colors.green.shade200,
              child: ListView.builder(
                itemBuilder: _listeElemanlariniOlustur,
                itemCount: tumDersler.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget uygulamaGovdesiLandscape() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //STATIC FORMU TUTON CONTAINER
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      //color: Colors.pink.shade200,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Ders Adı",
                                hintText: "Dersin adını giriniz",
                                hintStyle: TextStyle(fontSize: 18),
                                labelStyle: TextStyle(fontSize: 22),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                      color: Colors.purple, width: 2),
                                ),
                              ),
                              validator: (girilenDeger) {
                                if (girilenDeger.length > 0) {
                                  return null;
                                } else
                                  return "Ders adı boş girilemez";
                              },
                              onSaved: (kaydedilecekDeger) {
                                dersAdi = kaydedilecekDeger;
                                setState(() {
                                  tumDersler.add(
                                      Ders(dersAdi, dersHarfDegeri, dersKredi));
                                  ortalama = 0;
                                  ortalamayiHesapla();
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      items: dersKrediItems(),
                                      value: dersKredi,
                                      onChanged: (secilenKredi) {
                                        setState(() {
                                          dersKredi = secilenKredi;
                                        });
                                      },
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.purple, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                                Container(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<double>(
                                        items: dersHarfDegerleriItems(),
                                        value: dersHarfDegeri,
                                        onChanged: (secilenHarf) {
                                          setState(() {
                                            dersHarfDegeri = secilenHarf;
                                          });
                                        }),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.purple, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 70,
                        decoration: BoxDecoration(
                          border: BorderDirectional(
                            top: BorderSide(color: Colors.blue, width: 2),
                            bottom: BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: tumDersler.length == 0
                                        ? "Lütfen ders ekleyin"
                                        : "Ortalama : ",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black)),
                                TextSpan(
                                    text: tumDersler.length == 0
                                        ? " "
                                        : "${ortalama} ",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              color: Colors.green.shade200,
              child: ListView.builder(
                itemBuilder: _listeElemanlariniOlustur,
                itemCount: tumDersler.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKrediItems() {
    List<DropdownMenuItem<int>> krediler = [];

    for (int i = 0; i <= 10; i++) {
      krediler.add(DropdownMenuItem<int>(
        value: i,
        child: Text(
          "$i Kredi",
          style: TextStyle(fontSize: 30),
        ),
      ));
    }

    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "AA",
          style: TextStyle(fontSize: 30),
        ),
        value: 4.0,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "BA",
          style: TextStyle(fontSize: 30),
        ),
        value: 3.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "BB",
          style: TextStyle(fontSize: 30),
        ),
        value: 3.0,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "CB",
          style: TextStyle(fontSize: 30),
        ),
        value: 2.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "CC",
          style: TextStyle(fontSize: 30),
        ),
        value: 2.0,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "CD",
          style: TextStyle(fontSize: 30),
        ),
        value: 1.5,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "DD",
          style: TextStyle(fontSize: 30),
        ),
        value: 1.0,
      ),
    );
    harfler.add(
      DropdownMenuItem(
        child: Text(
          "FF",
          style: TextStyle(fontSize: 30),
        ),
        value: 0.0,
      ),
    );

    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    sayac++;
    debugPrint(sayac.toString());

    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamayiHesapla();
        });
      },
      child: Card(
        child: ListTile(
          title: Text(tumDersler[index].ad),
          subtitle: Text(tumDersler[index].kredi.toString() +
              "Kredi Ders Not Değeri : " +
              tumDersler[index].harfDegeri.toString()),
        ),
      ),
    );
  }

  void ortalamayiHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    for (var oAnkiDers in tumDersler) {
      var kredi = oAnkiDers.kredi;
      var harfDegeri = oAnkiDers.harfDegeri;

      toplamNot = toplamNot + (harfDegeri * kredi);
      toplamKredi += kredi;
    }

    ortalama = toplamNot / toplamKredi;
  }
}

class Ders {
  String ad;

  double harfDegeri;
  int kredi;

  Ders(
    this.ad,
    this.harfDegeri,
    this.kredi,
  );
}
