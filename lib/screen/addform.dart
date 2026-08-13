import 'package:flutter/material.dart';
import 'package:workshop3_124/models/foodmenu.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _component = '';
  int _price = 0;
  FoodType _foodType = FoodType.tom;
  Foodpic _foodpic = Foodpic.menu1;

  @override
  Widget build(BuildContext context) {
    // ใช้ Scaffold อย่างเดียว (ห้ามครอบ MaterialApp อีกชั้น เพราะจะทำให้ Navigator พัง)
    return Scaffold(
      appBar: AppBar(
        title: const Text("เพิ่มข้อมูล"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(), // ข้อ 21
            child: Column(
              children: [
                // 1. ชื่ออาหาร
                TextFormField(
                  maxLength: 20,
                  decoration: const InputDecoration(
                    label: Text(
                      "ชื่ออาหาร",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณาป้อนชื่ออาหาร";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),

                // 2. ส่วนประกอบสำคัญ
                TextFormField(
                  maxLength: 100,
                  decoration: const InputDecoration(
                    label: Text(
                      "ส่วนประกอบสำคัญ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณาป้อนส่วนประกอบสำคัญ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _component = value!;
                  },
                ),

                // 3. ราคา
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text(
                      "ราคา",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "กรุณาป้อนราคา";
                    }
                    if (int.tryParse(value) == null) {
                      return "กรุณาป้อนเป็นตัวเลข";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = int.parse(value!);
                  },
                ),

                // 4. ชนิดอาหาร (Dropdown FoodType)
                DropdownButtonFormField<FoodType>(
                  value: _foodType,
                  decoration: const InputDecoration(
                    label: Text(
                      "ชนิดอาหาร",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  items: FoodType.values.map((key) {
                    return DropdownMenuItem(
                      value: key,
                      child: Text(key.ty),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _foodType = value!;
                    });
                  },
                ),

                // 5. เลือกรูปภาพ (Dropdown Foodpic + แสดงชื่อและรูป)
                DropdownButtonFormField<Foodpic>(
                  value: _foodpic,
                  decoration: const InputDecoration(
                    label: Text(
                      "เลือกรูปภาพ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  items: Foodpic.values.map((pic) {
                    return DropdownMenuItem(
                      value: pic,
                      child: Row(
                        children: [
                          Text(pic.namefood),
                          const SizedBox(width: 10),
                          Image.asset(
                            pic.image,
                            width: 30,
                            height: 30,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.fastfood, size: 30),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _foodpic = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // 6. ปุ่มบันทึก
                FilledButton(
                  onPressed: () {
                    // ตรวจสอบก่อนบันทึก (ข้อ 9-10)
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // บันทึกลง List emp (ข้อ 11)
                      emp.add(
                        FoodMenu(
                          name: _name,
                          components: _component,
                          price: _price,
                          foodpic: _foodpic,
                          type: _foodType.ty,
                        ),
                      );

                      // ล้างฟอร์ม
                      _formKey.currentState!.reset();
                      setState(() {
                        _foodType = FoodType.tom;
                        _foodpic = Foodpic.menu1;
                      });

                      // กลับไปหน้าแสดงรายการ (ข้อ 16)
                      Navigator.pop(context);
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "บันทึก",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
