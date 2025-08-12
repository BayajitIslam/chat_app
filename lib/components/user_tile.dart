import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String email;
  final void Function()? ontap;
  const UserTile({super.key, required this.email,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(5)
        ),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        child: Row(
          children: [
            Icon(Icons.person),
            const SizedBox(width: 25,),
            Text(email),
          ],
        )
      ),
    );
  }
}
