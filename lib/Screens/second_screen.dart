import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';


void main(){

}class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
TextEditingController timePicker = TextEditingController();
TextEditingController datePicker = TextEditingController();
TextEditingController Status = TextEditingController();
List<String> _dropDownItem=["Flutter","Web","app"];

String _selectedTextFieldItem = "Flutter";


TextEditingController radioSelectionController = TextEditingController();
String? _selectedValue = 'Option 1';
List<String> _options = ['Option 1', 'Option 2', 'Option 3'];

void _openRadioDialog() async {
  final selectedValue = await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Select an Option'),
        children: _options.map((String value) {
          return RadioListTile<String>(
            title: Text(value),
            value: value,
            groupValue: _selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                _selectedValue = newValue!;
                Navigator.pop(context, newValue);
              });
            },
          );
        }).toList(),
      );
    },
  );

  if (selectedValue != null) {
    setState(() {
      radioSelectionController.text = selectedValue;
    });
  }
}
TextEditingController multiSelectController = TextEditingController();

List<String> _selectedItems = [];
List<MultiSelectItem<String>> _items = [
  MultiSelectItem('pooja', 'pooja'),
  MultiSelectItem('sonu', 'sonu'),
  MultiSelectItem('aa', 'aa'),
  MultiSelectItem('w', 'w'),
  MultiSelectItem('Eve', 'Eve'),
];
List<String> _filters = ['New', 'InProgress', 'Pending', ];
List<String> _selectedFilters = [];
List<String> _colorFilters = ['Low', 'Medium', 'High', ];
List<String> _selectedColorFilters = [];

void _openMultiSelect() async {
  final selectedValues = await showDialog<List<String>>(
    context: context,
    builder: (BuildContext context) {
      return MultiSelectDialog(
        items: _items,
        initialValue: _selectedItems,
        title: Text('Assign to'),
        searchable: true,
        onConfirm: (values) {
          setState(() {
            _selectedItems = values;
            multiSelectController.text = values.join(', ');
          });
        },
      );
    },
  );

  if (selectedValues != null) {
    setState(() {
      _selectedItems = selectedValues;
      multiSelectController.text = _selectedItems.join(', ');
    });
  }
}

@override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Task Screen"),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             DropdownButtonFormField(
               value: _selectedTextFieldItem,
                 items: _dropDownItem.map((String item){
                   return DropdownMenuItem(
                     value: item,
                       child: Text(item),
                   );
                 }).toList(),
                 onChanged: (String? value){
                 setState(() {
                   _selectedTextFieldItem = value!;
                 });
                 },
               icon: Icon(Icons.arrow_drop_down),
               decoration: InputDecoration(
          
                 labelText: 'Task Type'
               ),
                 ) ,
          
              SizedBox(height: 20,),
              TextField(decoration: InputDecoration(
          
                  labelText: 'Task Description'
              ),), SizedBox(height: 20,),
              TextField(
                controller: multiSelectController,
                decoration: InputDecoration(
                  labelText: 'Assign to',
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                readOnly: true,
                onTap: _openMultiSelect,
              ),
               SizedBox(height: 20,),
              TextField(controller: datePicker,
                decoration: InputDecoration(

                    labelText: 'Due Date'
              ),

              onTap: ()async{
                DateTime? datetime= await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime(1980), lastDate: DateTime(2025));
                if(datetime!=null){
                  String formattedDate = DateFormat('dd-MM-yyyy').format(datetime);
                  setState(() {
                    datePicker.text = formattedDate;
                  });
                }
              },
          
            ),
          
               SizedBox(height: 20,),
              TextField(controller: timePicker,
                decoration: InputDecoration(
                    labelText: "Due Time"
              ),
                onTap: ()async{
                  var time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                    if(time  != null){
                      setState(() {
                        timePicker.text = time.format(context);
                      });
                    }
          
                },
              ), SizedBox(height: 20,),

              Row(
                children: [
                  Text("Status:",style: TextStyle(fontSize: 18),),
                ],
              ),

              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: _filters.map((String filter) {
                  return FilterChip(
                    label: Text(filter),
                    selected: _selectedFilters.contains(filter),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedFilters.add(filter);
                        } else {
                          _selectedFilters.removeWhere((String name) => name == filter);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 30),

              Row(
                children: [
                  Text("Priority:",style: TextStyle(fontSize: 18),),
                ],
              ),
          Wrap(
            spacing: 10.0,
            runSpacing: 4.0,
            children: _colorFilters.map((String filter) {
              return FilterChip(
                label: Text(filter),
                selected: _selectedColorFilters.contains(filter),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _selectedColorFilters.add(filter);
                    } else {
                      _selectedColorFilters.removeWhere((String name) => name == filter);
                    }
                  });
                },
              );
            }).toList(),
          ),

            ],
          ),
        ),
      ),
    );
  }
}

