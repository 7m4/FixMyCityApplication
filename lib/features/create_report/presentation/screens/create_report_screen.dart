import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/testing/local_report_store.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../reports/presentation/screens/report_details_screen.dart';
import 'report_success_screen.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  final _descriptionController = TextEditingController();
  final _imagePicker = ImagePicker();

  final _departments = const [
    ('قسم الطرق والبنية التحتية', 'صيانة الطرق والحفر والأرصفة والجسور.', Icons.construction),
    ('قسم النظافة والبيئة', 'النفايات والنظافة العامة والتلوث.', Icons.delete_outline),
    ('قسم الإنارة والكهرباء', 'أعمدة الإنارة ومشاكل الكهرباء.', Icons.lightbulb_outline),
    ('قسم المياه والصرف الصحي', 'تسرب المياه والفيضانات والصرف الصحي.', Icons.water_drop_outlined),
  ];

  final _categories = const [
    ('حفرة', 'حفرة أو هبوط في الطريق', Icons.warning_amber_outlined),
    ('فيضان ماء / صرف صحي', 'تسرب أو تجمع المياه', Icons.water_outlined),
    ('انقطاع الكهرباء', 'تعطل عمود إنارة أو انقطاع الكهرباء', Icons.lightbulb_outline),
    ('النفايات', 'تراكم النفايات أو عدم جمعها', Icons.delete_outline),
    ('تلف الأرصفة', 'تلف الرصيف أو ممر المشاة', Icons.directions_walk),
  ];

  int _step = 0;
  int? _departmentIndex;
  int? _categoryIndex;
  String _location = 'شارع الجامعة، الزرقاء';
  double _markerX = 0.5;
  double _markerY = 0.5;
  XFile? _photo;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _choosePhoto(ImageSource source) async {
    try {
      final image = await _imagePicker.pickImage(source: source, imageQuality: 80, maxWidth: 1600);
      if (image != null) setState(() => _photo = image);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تعذّر فتح الصور. تحقق من أذونات التطبيق.')));
    }
  }

  void _next() {
    if (_step == 0 && _departmentIndex == null) {
      _message('يرجى اختيار القسم الإداري.');
      return;
    }
    if (_step == 1 && _categoryIndex == null) {
      _message('يرجى اختيار فئة المشكلة.');
      return;
    }
    if (_step < 4) {
      setState(() => _step++);
    } else {
      setState(() => _step = 5);
    }
  }

  void _back() {
    if (_step == 0) {
      Navigator.pop(context);
    } else {
      setState(() => _step--);
    }
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _submitReport() {
    final now = DateTime.now();
    final id = 'FMC-${now.year}-${now.millisecondsSinceEpoch.toString().substring(7)}';
    final report = <String, dynamic>{
      'id': id,
      'title': _categories[_categoryIndex!].$1,
      'category': _categories[_categoryIndex!].$1,
      'department': _departments[_departmentIndex!].$1,
      'location': _location,
      'date': '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      'status': 'قيد المراجعة',
      'description': _descriptionController.text.trim().isEmpty ? 'لم تتم إضافة وصف.' : _descriptionController.text.trim(),
      'photoPath': _photo?.path,
    };

    LocalReportStore.add(report);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ReportSuccessScreen(report: report)));
  }

  @override
  Widget build(BuildContext context) {
    final stepTitle = ['اختيار القسم', 'اختيار فئة المشكلة', 'تحديد موقع المشكلة', 'وصف البلاغ', 'إرفاق صورة', 'مراجعة البلاغ'];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(stepTitle[_step]),
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: _back),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(_step == 5 ? 'راجع بيانات البلاغ قبل الإرسال' : 'الخطوة ${_step + 1} من 5', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(value: (_step.clamp(0, 4) + 1) / 5, color: AppColors.primary, backgroundColor: AppColors.border),
                ]),
              ),
              Expanded(child: _buildStep()),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
                child: Row(children: [
                  if (_step > 0) ...[
                    Expanded(child: AppButton(label: 'السابق', outlined: true, onPressed: _back)),
                    const SizedBox(width: 10),
                  ],
                  Expanded(child: AppButton(
                    label: _step == 5 ? 'إرسال البلاغ' : 'التالي',
                    onPressed: _step == 5 ? _submitReport : _next,
                  )),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0: return _departmentStep();
      case 1: return _categoryStep();
      case 2: return _locationStep();
      case 3: return _descriptionStep();
      case 4: return _photoStep();
      default: return _reviewStep();
    }
  }

  Widget _departmentStep() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text('إلى أي قسم يتبع بلاغك؟', style: TextStyle(color: AppColors.navy, fontSize: 19, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      const Text('اختر القسم الإداري المختص لمعالجة المشكلة.', style: TextStyle(color: AppColors.text)),
      const SizedBox(height: 16),
      ...List.generate(_departments.length, (index) {
        final item = _departments[index];
        return _choiceCard(index == _departmentIndex, item.$1, item.$2, item.$3, () => setState(() => _departmentIndex = index));
      }),
    ],
  );

  Widget _categoryStep() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text('ما نوع المشكلة؟', style: TextStyle(color: AppColors.navy, fontSize: 19, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      Text('القسم المحدد: ${_departments[_departmentIndex!].$1}', style: const TextStyle(color: AppColors.primary)),
      const SizedBox(height: 16),
      ...List.generate(_categories.length, (index) {
        final item = _categories[index];
        return _choiceCard(index == _categoryIndex, item.$1, item.$2, item.$3, () => setState(() => _categoryIndex = index));
      }),
    ],
  );

  Widget _choiceCard(bool selected, String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AppCard(
          backgroundColor: selected ? AppColors.primaryLight : Colors.white,
          child: Row(children: [
            CircleAvatar(backgroundColor: AppColors.primaryLight, child: Icon(icon, color: AppColors.primary)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: AppColors.text, fontSize: 12)),
            ])),
            Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, color: AppColors.primary),
          ]),
        ),
      ),
    );
  }

  Widget _locationStep() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text('حدد مكان المشكلة بدقة', style: TextStyle(color: AppColors.navy, fontSize: 19, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      const Text('حرّك المؤشر على الخريطة التوضيحية لتحديد موقع المشكلة.', style: TextStyle(color: AppColors.text)),
      const SizedBox(height: 16),
      GestureDetector(
        onPanUpdate: (details) {
          final box = context.findRenderObject() as RenderBox?;
          if (box == null) return;
          final local = box.globalToLocal(details.globalPosition);
          setState(() {
            _markerX = (local.dx / box.size.width).clamp(0.1, 0.9);
            _markerY = (local.dy / box.size.height).clamp(0.1, 0.9);
          });
        },
        child: Container(
          height: 340,
          decoration: BoxDecoration(color: const Color(0xFFECF2EF), borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
          child: Stack(children: [
            Positioned.fill(child: CustomPaint(painter: _MapPainter())),
            Positioned(left: 18, top: 18, child: _mapLabel('حديقة')),
            Positioned(right: 20, bottom: 22, child: _mapLabel('شارع الجامعة')),
            Align(
              alignment: Alignment(_markerX * 2 - 1, _markerY * 2 - 1),
              child: const Icon(Icons.location_on, color: AppColors.primary, size: 44),
            ),
          ]),
        ),
      ),
      const SizedBox(height: 14),
      TextFormField(
        initialValue: _location,
        decoration: const InputDecoration(labelText: 'العنوان أو وصف الموقع', prefixIcon: Icon(Icons.location_on_outlined)),
        onChanged: (value) => _location = value,
      ),
      const SizedBox(height: 8),
      const Text('الخريطة في هذه النسخة تجريبية ولا تستخدم GPS فعلياً.', style: TextStyle(color: AppColors.text, fontSize: 12)),
    ],
  );

  Widget _mapLabel(String label) => Container(
    padding: const EdgeInsets.all(7),
    decoration: BoxDecoration(color: Colors.white.withValues(alpha: .85), borderRadius: BorderRadius.circular(7)),
    child: Text(label, style: const TextStyle(color: AppColors.text, fontSize: 11)),
  );

  Widget _descriptionStep() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text('أخبرنا المزيد عن المشكلة', style: TextStyle(color: AppColors.navy, fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('أضف وصفاً واضحاً يساعد الجهات المختصة على فهم البلاغ والتعامل معه.', style: TextStyle(color: AppColors.text, height: 1.6)),
      const SizedBox(height: 22),
      const Text('وصف المشكلة', style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      TextField(
        controller: _descriptionController,
        maxLength: 200,
        maxLines: 6,
        decoration: const InputDecoration(hintText: 'اكتب وصفاً مختصراً للمشكلة...', alignLabelWithHint: true),
      ),
      const SizedBox(height: 12),
      const AppCard(backgroundColor: AppColors.primaryLight, child: Text('يرجى ذكر تفاصيل المشكلة ومكان ظهورها إن أمكن.', style: TextStyle(color: AppColors.primary, height: 1.6))),
    ],
  );

  Widget _photoStep() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text('أرفق صورة توضّح المشكلة', style: TextStyle(color: AppColors.navy, fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('تساعد الصورة الجهة المختصة على فهم المشكلة والتحقق منها بشكل أسرع.', style: TextStyle(color: AppColors.text, height: 1.6)),
      const SizedBox(height: 20),
      AppCard(
        padding: const EdgeInsets.all(14),
        child: Column(children: [
          if (_photo == null)
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.add_a_photo_outlined, size: 72, color: AppColors.primary),
            )
          else
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(File(_photo!.path), height: 220, width: double.infinity, fit: BoxFit.cover)),
          const SizedBox(height: 16),
          Text(_photo == null ? 'لم يتم اختيار صورة بعد' : 'تم اختيار الصورة بنجاح', style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          AppButton(label: 'اختيار صورة من الجهاز', icon: Icons.photo_library_outlined, onPressed: () => _choosePhoto(ImageSource.gallery)),
          const SizedBox(height: 8),
          AppButton(label: 'التقاط صورة بالكاميرا', outlined: true, icon: Icons.camera_alt_outlined, onPressed: () => _choosePhoto(ImageSource.camera)),
          if (_photo != null) TextButton(onPressed: () => setState(() => _photo = null), child: const Text('إزالة الصورة')),
        ]),
      ),
      const SizedBox(height: 10),
      const Text('يمكنك المتابعة دون صورة في هذه النسخة التجريبية.', style: TextStyle(color: AppColors.text, fontSize: 12)),
    ],
  );

  Widget _reviewStep() => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Text('تأكد من صحة التفاصيل التالية قبل إرسال البلاغ.', style: TextStyle(color: AppColors.text)),
      const SizedBox(height: 16),
      _reviewRow('القسم المختص', _departments[_departmentIndex!].$1),
      _reviewRow('نوع المشكلة', _categories[_categoryIndex!].$1),
      _reviewRow('الموقع', _location),
      _reviewRow('الوصف', _descriptionController.text.trim().isEmpty ? 'لم تتم إضافة وصف.' : _descriptionController.text.trim()),
      _reviewRow('الصورة', _photo == null ? 'لم يتم إرفاق صورة' : 'صورة مرفقة'),
      const SizedBox(height: 12),
      const AppCard(backgroundColor: AppColors.primaryLight, child: Text('بعد الإرسال سيظهر رقم تتبع تجريبي. لا يتم إرسال البيانات إلى خادم في الوقت الحالي.', style: TextStyle(color: AppColors.primary, height: 1.6))),
    ],
  );

  Widget _reviewRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: AppColors.text, fontSize: 12)),
      const SizedBox(height: 6),
      Text(value, style: const TextStyle(color: AppColors.navy, fontWeight: FontWeight.w600, height: 1.5)),
    ])),
  );
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final building = Paint()..color = const Color(0xFFD2E0D9);
    final road = Paint()..color = const Color(0xFFFDFEFC);
    for (var row = 0; row < 3; row++) {
      for (var col = 0; col < 3; col++) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTWH(col * size.width / 3 + 8, row * size.height / 3 + 8, size.width / 3 - 20, size.height / 3 - 20), const Radius.circular(9)),
          building,
        );
      }
    }
    canvas.drawRect(Rect.fromLTWH(0, size.height * .32, size.width, 22), road);
    canvas.drawRect(Rect.fromLTWH(0, size.height * .68, size.width, 22), road);
    canvas.drawRect(Rect.fromLTWH(size.width * .32, 0, 22, size.height), road);
    canvas.drawRect(Rect.fromLTWH(size.width * .68, 0, 22, size.height), road);
  }
  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) => false;
}
