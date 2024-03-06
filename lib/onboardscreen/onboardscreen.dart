
import 'package:flutter/material.dart';
import 'package:oxyboots/onboardscreen/onboredmodel.dart';
import 'package:oxyboots/ui/home_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  late PageController _controller;
  @override
  void initState() {
   _controller = PageController(initialPage: 0);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: content.length,
                onPageChanged: (int index){
                setState(() {
                  currentPage = index;
                });
                },
                itemBuilder: (_,i){
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40,),
                      Image.asset(content[i].image.toString(),),
                      const SizedBox(height: 20,),
                      Text(content[i].title.toString(),style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),),
                      const SizedBox(height: 20,),
                      Text(content[i].discription.toString(),style: const TextStyle(
                        fontSize: 20,
                        color: Colors.grey
                      ),)
                    ],
                  ),
                );

                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              content.length,
                  (index) => buildDot(index: index),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 55,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:  Center(
                    child: InkWell(
                      child:  Text(currentPage==content.length-1?"Get Started" : "Next",style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),),
                      onTap: (){
                        if(currentPage==content.length-1){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Homepage(),));
                        }
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceIn);

                      },
                    ),
                  ),

                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
Widget buildDot({required int index}) {
  int currentPage = 0;
  return AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    margin: const EdgeInsets.only(right: 5),
    height: 10,
    width: currentPage == index ? 20 : 10,
    decoration: BoxDecoration(
      color: currentPage == index ? Colors.blue : Colors.grey,
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

