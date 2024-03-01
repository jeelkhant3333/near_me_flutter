import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nearme/src/provider/saved_places_provider.dart';
import 'package:nearme/src/views/deatil_page.dart';

class SavedScreen extends ConsumerStatefulWidget {
  const SavedScreen({super.key});

  @override
  ConsumerState<SavedScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends ConsumerState<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final saved = ref.read(savedPlaceProvider);
    return Scaffold(
      body: SafeArea(
        child:saved.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: const ShapeDecoration(
                  shape: OvalBorder(
                    side: BorderSide(width: 2, color: Color(0xFFE7E5E5)),
                  ),
                ),
                child:  const Center(
                  child: Icon(
                    Icons.bookmark_border,
                    size: 80,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Empty',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Start Building your travel Plan by saving\ninspiring destinations and Experiences  ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5F5C5C),
                  fontSize: 15,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAEDF4),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child:  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Image.asset('Assets/Vector.jpeg'),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: saved.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>DetailPage(c: saved[index])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top:10,left:8,right:8),
                      child: Container(
                        height: h * 0.2,
                        width: double.infinity,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF6F6F6),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 2, color: Color(0xFFC1C1C1)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 16,
                              offset: Offset(0, 8),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: w * 0.38,
                              height: h * 0.25,
                              decoration: ShapeDecoration(
                                image:  DecorationImage(
                                  image: NetworkImage(
                                      saved[index].imageUrl),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                bottom: 20,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: w*0.3,
                                        child: Text(
                                          saved[index].title,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: -0.17,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            ref.read(savedPlaceProvider.notifier)
                                                .deleteSavePlace(saved[index]);
                                          });

                                        },
                                        icon: const Icon(
                                          Icons.delete_forever_outlined,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: w * 0.45,
                                    child:  Text(
                                      saved[index].info,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: const TextStyle(
                                        color: Color(0xFF3B3A3A),
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        saved[index].rating.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Center(
                                        child: RatingBar.builder(
                                          initialRating: 5,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: saved[index].rating.toInt(),
                                          itemSize: 20,
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      const Text(
                                        '(45K)',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
