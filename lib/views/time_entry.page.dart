import 'package:flutter/material.dart';

class TimeEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Entry Page'),
      ),
      body: DefaultTabController(
        length: 3, // Number of tabs (Actual, Declared, Details)
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Actual'),
                Tab(text: 'Declared'),
                Tab(text: 'Details'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  buildActualTab(), // Actual year data table with dropdown
                  buildMonthDataTable(), // Declared year data table
                  buildDetailsDataTable(), // Details data table
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActualTab() {
    // Add logic here to get the list of available years
    List<int> years = [2023, 2022, 2021]; // Example list of years

    int selectedYear = years.first; // Default selected year

    return Column(
      children: [
        DropdownButton<int>(
          value: selectedYear,
          items: years.map((int year) {
            return DropdownMenuItem<int>(
              value: year,
              child: Text(year.toString()),
            );
          }).toList(),
          onChanged: (int? newValue) {
            if (newValue != null) {
              // Add logic here to handle year change
            }
          },
        ),

        buildMonthDataTable(), // Actual year data table
      ],
    );
  }

  Widget buildMonthDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('January')),
          DataColumn(label: Text('February')),
          DataColumn(label: Text('March')),
          DataColumn(label: Text('April')),
          DataColumn(label: Text('May')),
          DataColumn(label: Text('June')),
          DataColumn(label: Text('July')),
          DataColumn(label: Text('August')),
          DataColumn(label: Text('September')),
          DataColumn(label: Text('October')),
          DataColumn(label: Text('November')),
          DataColumn(label: Text('December')),
        ],
        rows: [
          DataRow(cells: List.generate(12, (index) => DataCell(Text('')))),
          DataRow(cells: List.generate(12, (index) => DataCell(Text('')))),
        ],
      ),
    );
  }

  Widget buildDetailsDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Day')),
          DataColumn(label: Text('Shift From')),
          DataColumn(label: Text('Shift To')),
          DataColumn(label: Text('Time In')),
          DataColumn(label: Text('Time Out')),
          DataColumn(label: Text('Regular Hours')),
          DataColumn(label: Text('Regular Amount')),
          DataColumn(label: Text('Overtime Hours')),
          DataColumn(label: Text('Overtime Amount')),
          DataColumn(label: Text('Night Diff Hours')),
          DataColumn(label: Text('Night Diff Among')),
          DataColumn(label: Text('Night Diff OT Hours')),
          DataColumn(label: Text('Night Diff OT Amount')),
          DataColumn(label: Text('Rest Day Hours')),
          DataColumn(label: Text('Rest Day Amount')),
          DataColumn(label: Text('Holiday Pay')),
        ],
        rows: [
          DataRow(cells: List.generate(17, (index) => DataCell(Text('')))),
        ],
      ),
    );
  }
}
