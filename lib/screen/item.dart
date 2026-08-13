import 'package:flutter/material.dart';
import 'package:workshop3_124/models/foodmenu.dart';
import 'package:workshop3_124/screen/addform.dart';

class Item extends StatefulWidget {
  const Item({super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  Color _getCardColor(String type) {
    switch (type) {
      case "ต้ม":
        return Colors.lightBlueAccent.shade100;
      case "ผัด":
      case "ผัก":
        return Colors.greenAccent.shade100;
      case "ย่าง":
        return Colors.orangeAccent.shade100;
      case "ทอด":
        return Colors.redAccent.shade100;
      case "อบ":
        return Colors.amberAccent.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. ส่วนแสดงรายการอาหาร (ห่อด้วย Expanded ตามข้อ 13)
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            itemCount: emp.length,
            itemBuilder: (context, index) {
              final food = emp[index];

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: _getCardColor(food.type),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "ประเภทอาหาร: ${food.type}",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade800),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "ส่วนประกอบ: ${food.components}",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey.shade700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "ราคา: ${food.price} บาท",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          food.foodpic.image,
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: 75,
                            height: 75,
                            color: Colors.grey.shade300,
                            child:
                                const Icon(Icons.fastfood, color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // 2. ปุ่มไอคอน + Routing (ข้อ 14-15)
        SizedBox(
          width: 100,
          height: 80,
          child: IconButton(
            icon: const Icon(
              Icons.add,
              size: 40,
              color: Colors.amber,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddForm()),
              ).then((_) {
                // รีเฟรช list หลังกลับจากหน้าเพิ่มข้อมูล
                setState(() {});
              });
            },
          ),
        ),
      ],
    );
  }
}
