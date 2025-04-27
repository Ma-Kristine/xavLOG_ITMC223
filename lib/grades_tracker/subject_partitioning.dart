import 'package:flutter/material.dart';

class SubjectPartitioningScreen extends StatefulWidget {
  final String subjectName;
  final List<String> addedPartitions;

  const SubjectPartitioningScreen({
    Key? key,
    required this.subjectName,
    required this.addedPartitions,
  }) : super(key: key);

  @override
  _SubjectPartitioningScreenState createState() => _SubjectPartitioningScreenState();
}

class _SubjectPartitioningScreenState extends State<SubjectPartitioningScreen> {
  late List<Map<String, String>> partitions;
  bool showOverlay = false;

  final partitionNameController = TextEditingController();
  final percentageController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    partitions = List.from(widget.addedPartitions);
  }

  void _addPartition() {
    if (partitionNameController.text.isNotEmpty) {
      setState(() {
        partitions.add({
          'name': partitionNameController.text,
          'percentage': percentageController.text,
        });
        showOverlay = false;
        partitionNameController.clear();
        percentageController.clear();
        descriptionController.clear();
      });
    }
  }

  @override
  void dispose() {
    partitionNameController.dispose();
    percentageController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: const Text(
                  "xavLOG",
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              // Decorative Ellipses
              Positioned(
                top: MediaQuery.of(context).size.height * 0.33,
                left: MediaQuery.of(context).size.width * 0.30,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(222, 28, 35, 162),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.14,
                left: -MediaQuery.of(context).size.width * 0.05,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE14B5A),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.09,
                left: MediaQuery.of(context).size.width * 0.53,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF2CB4EC),
                  ),
                ),
              ),

              // Main content
              Column(
                children: [
                  SizedBox(height: 120.0),
                  if (partitions.isNotEmpty)
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            '${widget.subjectName}  ',
                            style: TextStyle(
                              fontFamily: 'Jost',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 24.0),
                            child: const Divider(
                              color: Color(0xFFD7A61F),
                              thickness: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  Expanded(
                    child: partitions.isEmpty
                        ? Center(
                            child: Text(
                              "No partitions",
                              style: TextStyle(
                                fontSize: 16, 
                                fontFamily: 'Jost'
                              ),
                            ),
                          )
                        : Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: ListView(
                            children: partitions.map((partitionData) {
                              final name = partitionData['name']!;
                              final percentage = partitionData['percentage']!;
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SubjectPartitioningScreen(
                                          subjectName: name, 
                                          addedPartitions: [],
                                          ),
                                        ),
                                      );
                                    },
                                    child: 
                                      Container(
                                          width: 380, // Matches QPI padding width
                                          height: 45,
                                          margin: EdgeInsets.symmetric(horizontal: 16.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE8E8EB),
                                            borderRadius: BorderRadius.circular(9), // Sets corner radius
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 27.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  name,
                                                  style: TextStyle(
                                                    fontFamily: 'Jost',
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '${percentage} %',
                                                  style: TextStyle(
                                                    fontFamily: 'Jost',
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFFC59C2C),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ),
                                  ),
                                  SizedBox(height: 12.0),
                                ],
                              );
                            }).toList(),
                          )
                        )
                  ),
                ],
              ),

              // QPI container
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 5.3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 380,
                      height: 81,
                      color: const Color(0xFFD7A61F),
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'CFRS',
                            style: TextStyle(
                              fontFamily: 'Jost',
                              fontWeight: FontWeight.w600,
                              fontSize: 29.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '100 | A+',
                            style: TextStyle(
                              fontFamily: 'Jost',
                              fontWeight: FontWeight.w600,
                              fontSize: 29.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Floating Action Button
              Positioned(
                bottom: 40.0,
                right: 20.0,
                child: Material(
                  elevation: 6.0,
                  shape: CircleBorder(),
                  color: Color(0xFFD7A61F),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showOverlay = true;
                      });
                    },
                    child: Container(
                      width: 68.0,
                      height: 68.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 34.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Overlay + dimmed effect
        if (showOverlay) ...[
          GestureDetector(
            onTap: () {
              setState(() {
                showOverlay = false;
              });
            },
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: Stack(
              children: [
                Container(
                  width: 375,
                  height: 315,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
                    child: Column(
                      children: [
                        buildInputField("Partition Name* (e.g., Exams)", controller: partitionNameController),
                        SizedBox(height: 18),
                        buildInputField("Percentage*", controller: percentageController),
                        SizedBox(height: 18),
                        buildInputField("Description", isLarge: true, controller: descriptionController),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  right: 17.0,
                  child: GestureDetector(
                    onTap: _addPartition,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 21.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

Widget buildInputField(String hintText, {bool isLarge = false, required TextEditingController controller}) {
  return Material(
    child: Container(
      width: 323,
      height: isLarge ? 90.9 : 48.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 217, 217, 219),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontFamily: 'Jost',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF475569),
            ),
          ),
          style: TextStyle(
            fontFamily: 'Jost',
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}

// next sprint features: 
// delete,
// save,
// numerical grade switching,
// and computation