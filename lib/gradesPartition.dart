import 'package:flutter/material.dart';

class GradesPartitionScreen extends StatefulWidget {
  final String partitionName;
  final String partitionScore;
  final List<String> addedGradePartitions;
  final String subjectName;

  const GradesPartitionScreen({
    Key? key,
    required this.partitionName,
    required this.partitionScore,
    required this.addedGradePartitions,
    required this.subjectName,
  }) : super(key: key);

  @override
  _GradesPartitionScreenState createState() => _GradesPartitionScreenState();
}

class _GradesPartitionScreenState extends State<GradesPartitionScreen> {
  late List<Map<String, String>> partitions;
  bool showOverlay = false;
  bool showAdditionalInput = false;

  final partitionNameController = TextEditingController();
  final percentageController = TextEditingController();
  final scoreController = TextEditingController();
  final additionalController = TextEditingController();

  String lastInputFieldLabel = '...';

  @override
  void initState() {
    super.initState();
    partitions = [];

    percentageController.addListener(() {
      String input = percentageController.text.trim().toLowerCase();
      if (input == 'y') {
        setState(() {
          showAdditionalInput = false;
          lastInputFieldLabel = 'Percentage';
        });
      } else if (input == 'n') {
        setState(() {
          showAdditionalInput = true;
          lastInputFieldLabel = 'Score';
        });
      } else {
        setState(() {
          showAdditionalInput = false;
          lastInputFieldLabel = '...';
        });
      }
    });
  }

  void _addPartition() {
    if (partitionNameController.text.isNotEmpty && percentageController.text.isNotEmpty) {
      setState(() {
        String finalPercentage = percentageController.text.trim().toLowerCase() == 'n'
            ? scoreController.text.trim()
            : percentageController.text.trim();

        partitions.add({
          'name': partitionNameController.text.trim(),
          'percentage': finalPercentage,
        });

        showOverlay = false;
        partitionNameController.clear();
        percentageController.clear();
        scoreController.clear();
        additionalController.clear();
        lastInputFieldLabel = '...';
        showAdditionalInput = false;
      });
    }
  }

  @override
  void dispose() {
    partitionNameController.dispose();
    percentageController.dispose();
    scoreController.dispose();
    additionalController.dispose();
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
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Text(
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
              _buildDecorations(context),
              Column(
                children: [
                  const SizedBox(height: 120.0),
                  _buildSubjectHeader(),
                  Expanded(child: _buildPartitionList()),
                ],
              ),
              _buildQpiHeader(),
              _buildFab(),
            ],
          ),
        ),
        if (showOverlay) _buildOverlay(),
      ],
    );
  }

  Widget _buildDecorations(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.33,
          left: MediaQuery.of(context).size.width * 0.30,
          child: _buildCircle(34, const Color(0xFF2CB4EC)),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.14,
          left: -MediaQuery.of(context).size.width * 0.05,
          child: _buildCircle(80, const Color(0xFFE14B5A)),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.09,
          left: MediaQuery.of(context).size.width * 0.53,
          child: _buildCircle(25, const Color(0xFFEFB924)),
        ),
      ],
    );
  }

  Widget _buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _buildSubjectHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            '${widget.subjectName}  ',
            style: const TextStyle(
              fontFamily: 'Jost',
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: Divider(
              color: Color(0xFF283AA3),
              thickness: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPartitionList() {
    if (partitions.isEmpty) {
      return const Center(
        child: Text(
          "No partitions",
          style: TextStyle(fontSize: 16, fontFamily: 'Jost'),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20.0),
      itemCount: partitions.length,
      itemBuilder: (context, index) {
        final partition = partitions[index];
        return _buildPartitionCard(partition);
      },
    );
  }

  Widget _buildPartitionCard(Map<String, String> partition) {
    final name = partition['name']!;
    final percentage = partition['percentage']!;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GradesPartitionScreen(
                  partitionName: name,
                  partitionScore: percentage,
                  addedGradePartitions: [],
                  subjectName: widget.subjectName,
                ),
              ),
            );
          },
          child: Container(
            width: 380,
            height: 45,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8EB),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '$percentage%',
                    style: const TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF283AA3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }

  Widget _buildQpiHeader() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 5.3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 380,
            height: 81,
            color: const Color(0xFF283AA3),
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.partitionName,
                  style: const TextStyle(
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.w600,
                    fontSize: 29.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${widget.partitionScore}%',
                  style: const TextStyle(
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
    );
  }

  Widget _buildFab() {
    return Positioned(
      bottom: 40.0,
      right: 20.0,
      child: Material(
        elevation: 6.0,
        shape: const CircleBorder(),
        color: const Color(0xFF283AA3),
        child: InkWell(
          onTap: () {
            setState(() {
              showOverlay = true;
            });
          },
          child: Container(
            width: 68.0,
            height: 68.0,
            child: const Icon(Icons.add, color: Colors.white, size: 34.0),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Stack(
      children: [
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
                height: 270 + (showAdditionalInput ? 80 : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
                child: Column(
                  children: [
                    buildInputField("Partition Name*", controller: partitionNameController),
                    const SizedBox(height: 18),
                    buildInputField("Has other partitions? (y/n)*", controller: additionalController),
                    const SizedBox(height: 18),
                    buildInputField('Precentage*', controller: percentageController),
                    if (showAdditionalInput) ...[
                      const SizedBox(height: 18),
                      buildInputField("Score", controller: scoreController),
                    ]
                  ],
                ),
              ),
              Positioned(
                bottom: 20.0,
                right: 17.0,
                child: GestureDetector(
                  onTap: _addPartition,
                  child: const Icon(Icons.arrow_forward_ios, size: 21.0, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
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
        color: const Color.fromARGB(255, 217, 217, 219),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: const TextStyle(
              fontFamily: 'Jost',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF475569),
            ),
          ),
          style: const TextStyle(
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
// error handling
// computation,
// database,
// CRUD,
// save

// note! fix the y/n conditional statements