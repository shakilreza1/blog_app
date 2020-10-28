import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:blogg_app/services/crud.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();

  Stream blogsStream;


  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        blogsStream = result;
      });
    });
    super.initState();
  }

  Future<Null> getRefreshTwo()async{
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      crudMethods;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.withOpacity(0.4),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
            ),
            SizedBox(width: 0.0,),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blueGrey),
            )
          ],
        ),
        backgroundColor: Colors.tealAccent,
        elevation: 0.0,
      ),
      body: StreamBuilder(
        stream: blogsStream,
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,));
          }
          else{
            return RefreshIndicator(
              onRefresh: getRefreshTwo,
              child: ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  //var ourData = snapshot.data[index];
                  //color = _colorItems[index % _colorItems.length];
                  return Container(

                    height: MediaQuery.of(context).size.height-523.2,
                    margin: EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 10.0,
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: CachedNetworkImage(
                                alignment: Alignment.topCenter,
                                imageUrl: snapshot.data.documents[index].data['imgUrl'],
                                width: MediaQuery.of(context).size.width,
                                height: 230.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 10.0,),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height:30.0,
                                    width: 30.0,
                                    margin: EdgeInsets.all(0.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      child: Text(
                                        snapshot.data.documents[index].data["authorName"][0],

                                        style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                  SizedBox(width:0.0,),
                                  Container(
                                    margin: EdgeInsets.only(left:4.0),width: MediaQuery.of(context).size.width-80,
                                    child:Text(
                                      snapshot.data.documents[index].data["title"],
                                      style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.black),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(height: 5.0,),

                            Container(
                              height:30.0,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left:6.0,right:6.0),width: MediaQuery.of(context).size.width-40,
                                    child:Text("           "+
                                      snapshot.data.documents[index].data['desc'],
                                      maxLines: 2,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(color:Colors.black,fontSize: 15.0,fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.0,),

                            Container(

                              color: Colors.lightBlue.withOpacity(0.6),
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Icon(Icons.favorite_border,size: 25.0,color: Colors.white),
                                        ),

                                        Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Icon(Icons.share,size: 25.0,color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      customDialog(context,
                                        snapshot.data['imgUrl'],
                                        snapshot.data['title'],
                                        snapshot.data['desc'],
                                      );
                                      },
                                    child: Container(
                                      margin: EdgeInsets.only(right:4.0),
                                      child: Icon(Icons.more_horiz,size: 30.0,color: Colors.white,),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      /*floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),*/
    );
  }
}

customDialog(BuildContext context,String imgUrl,String title,String desc){
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
          child: Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blueGrey,Colors.blue,Colors.blueGrey]
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      child: Image.network(imgUrl,
                        height: 200.0,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25.0,fontWeight:FontWeight.bold,color: Colors.white),
                    ),
                  ),

                  SizedBox(height: 10.0,),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      desc,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20.0,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
  );

}

