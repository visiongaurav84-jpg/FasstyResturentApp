import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'owner_dashboard_screen.dart';

enum ApprovalStatus { pending, approved, rejected }

class ApprovalStatusScreen extends StatefulWidget {
  final ApprovalStatus status;
  final String? rejectionReason;

  const ApprovalStatusScreen({
    super.key,
    required this.status,
    this.rejectionReason,
  });

  @override
  State<ApprovalStatusScreen> createState() => _ApprovalStatusScreenState();
}

class _ApprovalStatusScreenState extends State<ApprovalStatusScreen> {
  @override
  void initState() {
    super.initState();

    /// Auto redirect if approved
    if (widget.status == ApprovalStatus.approved) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, "/dashboard");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _gradientColors(),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _statusIcon(),
                const SizedBox(height: 30),
                _titleText(),
                const SizedBox(height: 12),
                _descriptionText(),
                if (widget.status == ApprovalStatus.rejected &&
                    widget.rejectionReason != null)
                  _rejectionReason(),
                const SizedBox(height: 40),
                _actionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- UI COMPONENTS ----------------

  Widget _statusIcon() {
    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.2),
      ),
      child: Icon(
        _iconData(),
        size: 70,
        color: Colors.white,
      ),
    );
  }

  Widget _titleText() {
    return Text(
      _title(),
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _descriptionText() {
    return Text(
      _description(),
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Colors.white.withOpacity(0.9),
      ),
    );
  }

  Widget _rejectionReason() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          widget.rejectionReason!,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _actionButtons() {
    return Column(
      children: [
        if (widget.status != ApprovalStatus.approved)
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                /// Call approval status API again
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Refresh Status",
                style: GoogleFonts.poppins(
                  color: _primaryTextColor(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

        const SizedBox(height: 14),

        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OwnerDashboardScreen()),
            );
          },
          child: Text(
            "Proceed >>",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- HELPERS ----------------

  List<Color> _gradientColors() {
    switch (widget.status) {
      case ApprovalStatus.pending:
        return [Colors.orange.shade400, Colors.orange.shade700];
      case ApprovalStatus.approved:
        return [Colors.green.shade400, Colors.green.shade700];
      case ApprovalStatus.rejected:
        return [Colors.red.shade400, Colors.red.shade700];
    }
  }

  IconData _iconData() {
    switch (widget.status) {
      case ApprovalStatus.pending:
        return Icons.hourglass_top;
      case ApprovalStatus.approved:
        return Icons.check_circle_outline;
      case ApprovalStatus.rejected:
        return Icons.cancel_outlined;
    }
  }

  String _title() {
    switch (widget.status) {
      case ApprovalStatus.pending:
        return "Approval Pending";
      case ApprovalStatus.approved:
        return "Approved Successfully!";
      case ApprovalStatus.rejected:
        return "Approval Rejected";
    }
  }

  String _description() {
    switch (widget.status) {
      case ApprovalStatus.pending:
        return "Your restaurant profile is under review.\nThis usually takes 24–48 hours.";
      case ApprovalStatus.approved:
        return "Your restaurant has been approved.\nRedirecting to dashboard...";
      case ApprovalStatus.rejected:
        return "Unfortunately, your application was rejected.\nPlease review the reason below.";
    }
  }

  Color _primaryTextColor() {
    switch (widget.status) {
      case ApprovalStatus.pending:
        return Colors.orange.shade700;
      case ApprovalStatus.approved:
        return Colors.green.shade700;
      case ApprovalStatus.rejected:
        return Colors.red.shade700;
    }
  }
}
