import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/services/isolate_demo_service.dart';

class IsolateDemoPanel extends StatefulWidget {
  const IsolateDemoPanel({super.key});

  @override
  State<IsolateDemoPanel> createState() => _IsolateDemoPanelState();
}

class _IsolateDemoPanelState extends State<IsolateDemoPanel> {
  final _service = IsolateDemoService();
  String _status = 'Chưa khởi động';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _startIsolate();
  }

  Future<void> _startIsolate() async {
    setState(() => _status = 'Đang khởi động isolate...');
    try {
      await _service.start();
      if (!mounted) {
        return;
      }
      setState(() => _status = 'Isolate đã sẵn sàng');
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() => _status = 'Không thể khởi động isolate');
    }
  }

  Future<void> _runJob() async {
    setState(() {
      _loading = true;
      _status = 'Đang tính toán trên isolate... (Sum 0..100M)';
    });
    try {
      final result = await _service.calculateSum(100000000);
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _status = 'Kết quả: $result';
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _status = 'Tác vụ bị hủy: $error';
      });
    }
  }

  @override
  void dispose() {
    _service.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Isolate.spawn() Demo', style: AppTextStyles.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Isolate sống lâu dài - gửi nhiều job qua SendPort',
              style: AppTextStyles.bodySmall,
            ),
            const Divider(height: 20),
            Text(_status, style: AppTextStyles.bodyMedium),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _loading ? null : _runJob,
                icon: _loading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.play_arrow),
                label: Text(_loading ? 'Đang tính...' : 'Gửi job sang isolate'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
