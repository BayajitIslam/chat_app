import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String email;
  final void Function()? ontap;
  const UserTile({super.key, required this.email,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10,right: 20,left: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(4)
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(Icons.person),
                Text(email),
              ],
            ),
          )
        ),
      ),
    );
  }
}
