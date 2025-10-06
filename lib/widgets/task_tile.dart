import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final bool isDone;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.title,
    required this.isDone,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(title),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 28),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isDone
              ? LinearGradient(
              colors: [Colors.grey.shade300, Colors.grey.shade100])
              : LinearGradient(
              colors: [Colors.blue.shade200, Colors.blue.shade100]),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? Colors.green : Colors.white,
                border: Border.all(
                  color: isDone ? Colors.green : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isDone
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : null,
            ),
          ),
          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              decoration: isDone ? TextDecoration.lineThrough : null,
              color: isDone ? Colors.grey.shade700 : Colors.black87,
            ),
            child: Text(title),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
