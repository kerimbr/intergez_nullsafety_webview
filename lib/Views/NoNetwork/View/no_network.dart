import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:lottie/lottie.dart';

class NoNetworkView extends StatelessWidget {
  const NoNetworkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "İnternet Bağlantısı Yok!",
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(80),
                child: Lottie.asset(
                    "assets/lottie/no_connect.json",
                    fit: BoxFit.contain
                ),
              ),

              Text(
                "İnteret Bağlantısını Kontrol Ediniz.",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey
                ),
              ),

              SizedBox(height: 50),
              GestureDetector(
                onTap: (){
                  Phoenix.rebirth(context);
                },
                child: Container(
                  width: 200,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Tekrar Dene",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade200,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.deepOrange,
                            Colors.redAccent
                          ]
                      ),
                      borderRadius: BorderRadius.circular(60)
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
