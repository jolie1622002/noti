import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noti/MEDICINE.dart';
import 'package:noti/MedicineDetails.dart';
import 'package:noti/entryPage.dart';
import 'package:noti/global.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TopContainer(),
          Flexible(
            child: BottomContainer(),
          )
        ],
      ),
      floatingActionButton: InkResponse(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const EntryPage()));
        },
        child: SizedBox(
          child: Card(
            color: Colors.black,
            child: Icon(
              Icons.add_outlined,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Column(
      children: [
        Text("Don't worry"),
        StreamBuilder<List<Medicine>>(
          stream: globalBloc.medicineList$,
          builder: (context, snapshot) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                !snapshot.hasData ? '0' : snapshot.data!.length.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          },
        ),
      ],
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //   return Center(
    //       child: Text("no medicine",
    //       textAlign: TextAlign.center,
    //       style: Theme.of(context).textTheme.headlineLarge,));
    // }
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<List<Medicine>>(
        stream: globalBloc.medicineList$,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No Medicine',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          } else {
            return GridView.builder(
              padding: EdgeInsets.only(top: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return MedicineCard(medicine: snapshot.data![index]);
              },
            );
          }
        });
    // return
  }
}

class MedicineCard extends StatelessWidget {
  const MedicineCard({Key? key, required this.medicine}) : super(key: key);
  final Medicine medicine;
  Hero makeIcon(double size){
    return Hero(tag: medicine.medicineName!, child: Icon(Icons.error),);
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.cyan,
      splashColor: Colors.blueGrey,
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder<void>(pageBuilder:(BuildContext context,Animation<double> animation,
        Animation<double> SecondaryAnimation) {
          return AnimatedBuilder(
              animation: animation,
              builder: (context, Widget?child) {
                return Opacity(opacity: animation.value,
                child: MedicineDetails(medicine,),);
              });
        }));

        //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => MedicineDetails()));
      // 
       },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Hero(tag:medicine.medicineName!,
              child: Text(
               medicine.medicineName!,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              medicine.interval==1?
                  "Every ${medicine.interval} hour":
              "Every ${medicine.interval} hour",
              overflow: TextOverflow.fade,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        ),
        // width: 20,
        // height: 20,
        // color: Colors.black,
      ),
    );
  }
}
