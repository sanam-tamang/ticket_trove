import 'package:flutter/material.dart';

class TicketDialog extends StatefulWidget {
  final bool isTicketAvailable;
  final String? ticketQuantity;

  const TicketDialog(
      {Key? key, required this.isTicketAvailable, this.ticketQuantity})
      : super(key: key);

  @override
  State<TicketDialog> createState() => _TicketDialogState();
}

class _TicketDialogState extends State<TicketDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.isTicketAvailable
                  ? const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50,
                    )
                  : const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 50,
                    ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    widget.isTicketAvailable
                        ? 'Ticket Available'
                        : 'Ticket Unavailable',
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.inverseSurface),
                  ),
                  Text(
                    widget.ticketQuantity ?? "",
                    style: Theme.of(context).textTheme.headlineMedium,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
