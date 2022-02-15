import 'package:flutter/material.dart';

class PersonnelCard extends StatelessWidget {
  final String name;
  final String description;
  final double cost;

  final Function() addToRoster;
  const PersonnelCard({
    Key? key,
    required this.name,
    required this.description,
    required this.cost,
    required this.addToRoster,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    "Cost: \$ " + cost.toString(),
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
              IconButton(
                padding: const EdgeInsets.only(right: 11.0, top: 9),
                onPressed: addToRoster,
                iconSize: 40,
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.red,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              description,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
