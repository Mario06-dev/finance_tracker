import 'package:finance_tracker/constants/categories.dart';
import 'package:finance_tracker/models/category_model.dart';
import 'package:finance_tracker/providers/add_trans_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';

class ChooseCategoryScreen extends StatefulWidget {
  const ChooseCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ChooseCategoryScreen> createState() => _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends State<ChooseCategoryScreen> {
  // Used for search functionality
  final TextEditingController _searchController = TextEditingController();

  // Used for search filtering
  String searchWord = '';

  // All categories
  late List<Category> _categories = [];

  @override
  void initState() {
    _categories.addAll(categories);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Category> dummySearchList = [];
    dummySearchList.addAll(categories);
    if (query.isNotEmpty) {
      List<Category> dummyListData = [];
      _categories.forEach((item) {
        if (item.title.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _categories.clear();
        _categories.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _categories.clear();
        _categories.addAll(categories);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.xmark,
            size: 20,
            //color: blackTextColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        //backgroundColor: bgColor,
        title: Text(
          'Choose Category',
          style: GoogleFonts.prompt(
            //color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              //height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //color: Colors.black12,
                color: Theme.of(context).shadowColor,
              ),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.search,
                    //color: Colors.black38,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      cursorColor: primaryColor,
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          //searchWord = value;
                          filterSearchResults(value);
                        });
                      },
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: const InputDecoration(
                        //labelText: 'Search transactions ...',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        /* searchWord = '';
                        _searchController.text = ''; */
                        _categories.clear();
                        _categories.addAll(categories);
                        _searchController.text = '';
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      //color: Colors.black38,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      index != 0
                          ? (_categories[index].parentCategoryTitle !=
                                  _categories[index - 1].parentCategoryTitle)
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 10),
                                  child: Text(
                                    _categories[index].parentCategoryTitle,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                )
                              : Container()
                          : Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 10),
                              child: Text(
                                _categories[index].parentCategoryTitle,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                      InkWell(
                        onTap: () {
                          Provider.of<AddTransProvider>(context, listen: false)
                              .setCategory(_categories[index]);
                          Navigator.of(context).pop(3);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Theme.of(context).shadowColor,
                              child: Icon(
                                _categories[index].icon,
                                size: 16,
                                color: _categories[index].color,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(_categories[index].title,
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
