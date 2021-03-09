import 'package:flutter/material.dart';

class IconSelectorField extends StatelessWidget {
  final String title;
  final Function onTap;
  final Function onEdit;
  final IconData icon;
  final String profession;
  final bool isEditing;

  const IconSelectorField(
      {Key key,
      @required this.title,
      @required this.onTap,
      @required this.icon,
      @required this.onEdit,
      @required this.profession,
      @required this.isEditing})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEditing ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey[100],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ///Container for Icon
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromRGBO(255, 240, 240, 1)),
              padding: const EdgeInsets.all(16),
              child: Icon(
                icon,
                color: Colors.redAccent,
              ),
            ),

            ///For spacing
            SizedBox(
              width: 24,
            ),

            ///For Text
            isEditing
                ? Text(
                    title,
                  )
                : Text(profession),

            Spacer(),
            profession != null
                ? IconButton(
                    color: Colors.pink,
                    icon: Icon(isEditing ? Icons.save : Icons.edit),
                    onPressed: onEdit)
                : IconButton(
                    icon: Icon(Icons.select_all),
                    onPressed: onTap,
                  )
          ],
        ),
      ),
    );
  }
}
