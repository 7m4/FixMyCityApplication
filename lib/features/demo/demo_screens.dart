import 'package:flutter/material.dart';
import 'demo_data.dart';

const _primary = Color(0xFF075E63);
const _navy = Color(0xFF13374D);
const _muted = Color(0xFF526773);
const _background = Color(0xFFF3F6F7);
const _border = Color(0xFFD9E3E7);

class DemoRootScreen extends StatelessWidget {
  const DemoRootScreen({super.key});

  @override
  Widget build(BuildContext context) => const WelcomeScreen();
}

class _Page extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottom;
  final bool showBack;
  const _Page({required this.title, required this.child, this.bottom, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _background,
        appBar: AppBar(
          backgroundColor: _background,
          foregroundColor: _navy,
          elevation: 0,
          centerTitle: true,
          title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          leading: showBack ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.maybePop(context)) : null,
        ),
        body: SafeArea(child: child),
        bottomNavigationBar: bottom,
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const _PrimaryButton(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 54,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ),
  );
}

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const _Card({required this.child, this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _border),
    ),
    child: child,
  );
}

class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  const _Field(this.label, this.hint, {this.maxLines = 1});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: _navy, fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 8),
      TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF9AA9AF), fontSize: 14),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: _border)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: _border)),
        ),
      ),
    ],
  );
}

class _Status extends StatelessWidget {
  final String value;
  const _Status(this.value);

  @override
  Widget build(BuildContext context) {
    final color = value == 'تم الحل' ? const Color(0xFF247348) : value == 'مرفوض' ? const Color(0xFFB43F3B) : const Color(0xFF926313);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: color.withValues(alpha: .09), borderRadius: BorderRadius.circular(8)),
      child: Text(value, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => _Page(
    title: 'FixMyCity',
    showBack: false,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 22),
          const Text('أهلاً بك في FixMyCity', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: _navy)),
          const SizedBox(height: 10),
          const Text('تعرّف على التطبيق وكيف يساعدك على الإبلاغ عن مشاكل حيّك ومتابعتها.', style: TextStyle(color: _muted, height: 1.6)),
          const SizedBox(height: 28),
          Expanded(child: _Card(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.play_circle_outline, size: 64, color: _primary),
              SizedBox(height: 14),
              Text('سيُضاف الفيديو قريباً', style: TextStyle(color: _muted, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text('تعرّف على FixMyCity', style: TextStyle(color: _navy, fontWeight: FontWeight.bold)),
              Text('لم يُرفع الفيديو بعد', style: TextStyle(color: _muted, fontSize: 12)),
            ],
          ))),
          const SizedBox(height: 24),
          _PrimaryButton('متابعة الشرح', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()))),
          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PortalScreen())), child: const Text('تخطّي', style: TextStyle(color: _primary))),
        ],
      ),
    ),
  );
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int step = 0;
  final titles = ['التعرّف على التطبيق', 'القسم والموقع', 'نوع المشكلة وتفاصيلها', 'مراجعة البلاغ وإرساله', 'المتابعة والإشعارات'];
  final descriptions = [
    'يمكنك الإبلاغ عن مشاكل الحي مثل تراكم النفايات، انقطاع الإنارة، الحفر، تلف الأرصفة وتسرب المياه.',
    'اختر القسم المسؤول عن المشكلة ثم حدّد موقعها بدقة على الخريطة.',
    'اختر فئة المشكلة، أضف صورة واضحة، واكتب وصفاً مختصراً عند الحاجة.',
    'راجع بيانات البلاغ قبل الإرسال. بعد الإرسال سيصلك رقم مرجعي لمتابعته.',
    'تابع حالة البلاغ وسجل التحديثات، وستصلك إشعارات عند تغيير الحالة.',
  ];

  @override
  Widget build(BuildContext context) => _Page(
    title: 'التعرّف على التطبيق',
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('الخطوة ${step + 1} من 5', style: const TextStyle(color: _primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        LinearProgressIndicator(value: (step + 1) / 5, color: _primary, backgroundColor: _border),
        const SizedBox(height: 28),
        Text(titles[step], style: const TextStyle(fontSize: 24, color: _navy, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _Card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.info_outline, size: 34, color: _primary),
          const SizedBox(height: 16),
          Text(descriptions[step], style: const TextStyle(color: _muted, height: 1.8)),
        ])),
        const Spacer(),
        _PrimaryButton(step == 4 ? 'ابدأ الآن' : 'التالي', () {
          if (step == 4) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PortalScreen()));
          } else {
            setState(() => step++);
          }
        }),
        TextButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PortalScreen())), child: const Text('تخطّي الشرح')),
      ]),
    ),
  );
}

class PortalScreen extends StatefulWidget {
  const PortalScreen({super.key});
  @override
  State<PortalScreen> createState() => _PortalScreenState();
}

class _PortalScreenState extends State<PortalScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) => _Page(
    title: 'اختر بوابة الدخول',
    showBack: false,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('اختر البوابة المناسبة للمتابعة', style: TextStyle(color: _muted)),
        const SizedBox(height: 22),
        _portalCard(Icons.person_outline, 'بوابة المواطن', 'قدّم بلاغاتك وتابع حالتها في مدينتك.', 0),
        const SizedBox(height: 16),
        _portalCard(Icons.work_outline, 'بوابة الموظف', 'تابع مهامك وقم بإدارتها داخل مؤسستك.', 1),
        const Spacer(),
        _PrimaryButton('متابعة', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()))),
      ]),
    ),
  );

  Widget _portalCard(IconData icon, String title, String subtitle, int index) => InkWell(
    onTap: () => setState(() => selected = index),
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: selected == index ? _primary : _border, width: selected == index ? 2 : 1)),
      child: Column(children: [
        CircleAvatar(radius: 34, backgroundColor: const Color(0xFFEAF3F3), child: Icon(icon, size: 34, color: _primary)),
        const SizedBox(height: 14),
        Text(title, style: const TextStyle(color: _navy, fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(height: 5),
        Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: _muted, fontSize: 12)),
      ]),
    ),
  );
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => _Page(
    title: 'تسجيل الدخول',
    child: ListView(padding: const EdgeInsets.all(24), children: [
      Container(height: 130, decoration: BoxDecoration(color: _primary, borderRadius: BorderRadius.circular(24)), child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.location_city, color: Colors.white, size: 52),
        SizedBox(height: 8),
        Text('FixMyCity', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
      ])),
      const SizedBox(height: 26),
      const Center(child: Text('مرحباً بعودتك', style: TextStyle(color: _navy, fontSize: 25, fontWeight: FontWeight.bold))),
      const SizedBox(height: 8),
      const Text('أدخل بيانات الدخول للوصول إلى حسابك.', style: TextStyle(color: _muted)),
      const SizedBox(height: 24),
      const _Field('رقم الهوية', 'أدخل رقم الهوية'),
      const SizedBox(height: 16),
      const _Field('كلمة المرور', 'أدخل كلمة المرور'),
      Align(alignment: Alignment.centerLeft, child: TextButton(onPressed: () {}, child: const Text('نسيت كلمة المرور؟'))),
      const SizedBox(height: 12),
      _PrimaryButton('تسجيل الدخول', () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()))),
      const SizedBox(height: 10),
      OutlinedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterFlowScreen())), child: const Text('إنشاء حساب جديد')),
    ]),
  );
}

class RegisterFlowScreen extends StatefulWidget {
  const RegisterFlowScreen({super.key});
  @override
  State<RegisterFlowScreen> createState() => _RegisterFlowScreenState();
}

class _RegisterFlowScreenState extends State<RegisterFlowScreen> {
  int step = 0;
  final titles = ['لنبدأ بالتعرّف عليك', 'معلومات التواصل', 'أنشئ كلمة المرور'];
  @override
  Widget build(BuildContext context) => _Page(
    title: 'إنشاء الحساب',
    child: ListView(padding: const EdgeInsets.all(24), children: [
      LinearProgressIndicator(value: (step + 1) / 3, color: _primary, backgroundColor: _border),
      const SizedBox(height: 18),
      Text('الخطوة ${step + 1} من 3', style: const TextStyle(color: _primary, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Text(titles[step], style: const TextStyle(fontSize: 24, color: _navy, fontWeight: FontWeight.bold)),
      const SizedBox(height: 22),
      if (step == 0) ...[
        const _Field('الاسم الأول', 'أدخل الاسم الأول'),
        const SizedBox(height: 14),
        const _Field('الاسم الأوسط', 'أدخل الاسم الأوسط'),
        const SizedBox(height: 14),
        const _Field('الاسم الأخير', 'أدخل الاسم الأخير'),
        const SizedBox(height: 14),
        const _Field('الرقم الوطني', 'أدخل الرقم الوطني'),
      ] else if (step == 1) ...[
        const _Field('رقم الهاتف', '07X XXX XXXX'),
        const SizedBox(height: 14),
        const _Field('البريد الإلكتروني', 'name@example.com'),
      ] else ...[
        const _Field('كلمة المرور', 'أدخل كلمة المرور'),
        const SizedBox(height: 14),
        const _Field('تأكيد كلمة المرور', 'أعد إدخال كلمة المرور'),
        const SizedBox(height: 12),
        const _Card(child: Text('يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل، ورقم واحد، وحرف كبير.', style: TextStyle(color: _muted, height: 1.6))),
      ],
      const SizedBox(height: 24),
      _PrimaryButton(step == 2 ? 'إنشاء الحساب' : 'التالي', () {
        if (step == 2) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashboardScreen()), (_) => false);
        } else {
          setState(() => step++);
        }
      }),
      TextButton(onPressed: () => step == 0 ? Navigator.pop(context) : setState(() => step--), child: Text(step == 0 ? 'لديك حساب؟ تسجيل الدخول' : 'السابق')),
    ]),
  );
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) => _Page(
    title: 'FixMyCity',
    showBack: false,
    child: Column(children: [
      Expanded(child: ListView(padding: const EdgeInsets.all(24), children: [
        Text('مرحباً، ${DemoData.userName}', style: const TextStyle(color: _navy, fontSize: 23, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('إليك ملخص بلاغاتك الأخيرة.', style: TextStyle(color: _muted)),
        const SizedBox(height: 18),
        Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: _primary, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: const [Text('${DemoData.totalReports}', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)), SizedBox(width: 18), Text('إجمالي البلاغات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
          const SizedBox(height: 14),
          Row(children: [
            _statChip('${DemoData.activeReports} قيد المعالجة'),
            const SizedBox(width: 8),
            _statChip('${DemoData.completedReports} مكتمل'),
          ]),
        ])),
        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('البلاغات الأخيرة', style: TextStyle(color: _navy, fontSize: 17, fontWeight: FontWeight.bold)),
          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyReportsScreen())), child: const Text('عرض الكل')),
        ]),
        ...DemoData.reports.map((r) => _ReportTile(report: r)),
      ])),
      _BottomNav(onHome: () {}, onReports: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyReportsScreen())), onNotifications: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
    ]),
    bottom: null,
  );

  Widget _statChip(String text) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7), decoration: BoxDecoration(color: const Color(0xFF1C7578), borderRadius: BorderRadius.circular(8)), child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)));
}

class _BottomNav extends StatelessWidget {
  final VoidCallback onHome;
  final VoidCallback onReports;
  final VoidCallback onNotifications;
  const _BottomNav({required this.onHome, required this.onReports, required this.onNotifications});

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: _border))),
    padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 18),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _navItem(Icons.person_outline, 'حسابي', () {}),
      _navItem(Icons.notifications_none, 'الإشعارات', onNotifications),
      _navItem(Icons.folder_outlined, 'بلاغاتي', onReports),
      _navItem(Icons.home_outlined, 'الرئيسية', onHome),
    ]),
  );

  Widget _navItem(IconData icon, String label, VoidCallback action) => InkWell(onTap: action, child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: _primary), Text(label, style: const TextStyle(color: _muted, fontSize: 10))]));
}

class _ReportTile extends StatelessWidget {
  final DemoReport report;
  const _ReportTile({required this.report});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportDetailsScreen(report: report))),
    child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: _border)), child: Row(children: [
      const CircleAvatar(backgroundColor: Color(0xFFEAF3F3), child: Icon(Icons.report_problem_outlined, color: _primary)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(report.title, style: const TextStyle(color: _navy, fontWeight: FontWeight.bold)), const SizedBox(height: 4), Text(report.number, style: const TextStyle(color: _muted, fontSize: 11)), const SizedBox(height: 6), _Status(report.status)])),
      const Icon(Icons.chevron_left, color: _muted),
    ])),
  );
}

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({super.key});
  @override
  Widget build(BuildContext context) => _Page(
    title: 'بلاغاتي',
    child: ListView(padding: const EdgeInsets.all(24), children: [
      const Text('تابع جميع البلاغات التي قمت بإرسالها.', style: TextStyle(color: _muted)),
      const SizedBox(height: 16),
      ...DemoData.reports.map((r) => _ReportTile(report: r)),
      const SizedBox(height: 12),
      _PrimaryButton('إنشاء بلاغ جديد', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportWizardScreen()))),
    ]),
  );
}

class ReportDetailsScreen extends StatelessWidget {
  final DemoReport report;
  const ReportDetailsScreen({super.key, required this.report});
  @override
  Widget build(BuildContext context) => _Page(
    title: 'تفاصيل البلاغ',
    child: ListView(padding: const EdgeInsets.all(24), children: [
      _Card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(report.number, style: const TextStyle(color: _muted)),
        const SizedBox(height: 12),
        Text(report.title, style: const TextStyle(color: _navy, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _Status(report.status),
        const Divider(height: 28),
        _detail('الفئة', report.category),
        _detail('القسم المسؤول', report.department),
        _detail('الموقع', report.location),
        _detail('تاريخ الإرسال', report.date),
        _detail('الوصف', report.description),
      ])),
      const SizedBox(height: 18),
      OutlinedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StatusHistoryScreen())), icon: const Icon(Icons.timeline), label: const Text('عرض سجل حالة البلاغ')),
    ]),
  );

  Widget _detail(String label, String value) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: _muted, fontSize: 12)), const SizedBox(height: 4), Text(value, style: const TextStyle(color: _navy, fontWeight: FontWeight.w600))]));
}

class StatusHistoryScreen extends StatelessWidget {
  const StatusHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) => _Page(
    title: 'سجل حالة البلاغ',
    child: ListView(padding: const EdgeInsets.all(24), children: [
      const Text('FMC-2026-1042', style: TextStyle(color: _muted)),
      const SizedBox(height: 18),
      ...DemoData.statusHistory.map((s) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(s.$3 ? Icons.check_circle : Icons.radio_button_unchecked, color: s.$3 ? _primary : _border),
        title: Text(s.$1, style: const TextStyle(color: _navy, fontWeight: FontWeight.bold)),
        subtitle: Text(s.$2),
      )),
    ]),
  );
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) => _Page(
    title: 'الإشعارات',
    child: ListView(padding: const EdgeInsets.all(24), children: [
      const Text('مركز الإشعارات', style: TextStyle(color: _navy, fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      const Text('تابع آخر التحديثات المتعلقة ببلاغاتك', style: TextStyle(color: _muted)),
      const SizedBox(height: 16),
      _Card(child: const Text('لديك إشعاران غير مقروءين', style: TextStyle(color: _primary, fontWeight: FontWeight.bold))),
      const SizedBox(height: 12),
      ...DemoData.notifications.map((n) => _Card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(n.$1, style: const TextStyle(color: _navy, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(n.$2, style: const TextStyle(color: _muted, height: 1.5)),
        const SizedBox(height: 8),
        Text(n.$3, style: const TextStyle(color: _muted, fontSize: 11)),
      ]))),
    ]),
  );
}

class ReportWizardScreen extends StatefulWidget {
  const ReportWizardScreen({super.key});
  @override
  State<ReportWizardScreen> createState() => _ReportWizardScreenState();
}

class _ReportWizardScreenState extends State<ReportWizardScreen> {
  int step = 0;
  String? department;
  String? category;
  final locationController = TextEditingController(text: 'شارع الجامعة، الزرقاء');
  final descriptionController = TextEditingController(text: 'توجد مشكلة تحتاج إلى معالجة من القسم المختص.');
  final steps = ['اختيار القسم الإداري', 'اختيار فئة المشكلة', 'تحديد الموقع', 'وصف المشكلة', 'إرفاق صورة', 'مراجعة البلاغ'];

  @override
  void dispose() {
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _Page(
    title: 'إنشاء بلاغ',
    child: Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(24, 14, 24, 8), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('الخطوة ${step + 1} من 6 · ${steps[step]}', style: const TextStyle(color: _primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        LinearProgressIndicator(value: (step + 1) / 6, color: _primary, backgroundColor: _border),
      ])),
      Expanded(child: ListView(padding: const EdgeInsets.all(24), children: [
        Text(steps[step], style: const TextStyle(color: _navy, fontSize: 23, fontWeight: FontWeight.bold)),
        const SizedBox(height: 18),
        if (step == 0) ...[
          const Text('اختر الجهة المسؤولة عن معالجة المشكلة.', style: TextStyle(color: _muted)),
          const SizedBox(height: 14),
          ...DemoData.departments.map((d) => _choice(d, department == d, () => setState(() => department = d))),
        ] else if (step == 1) ...[
          const Text('حدد نوع المشكلة التي تريد الإبلاغ عنها.', style: TextStyle(color: _muted)),
          const SizedBox(height: 14),
          ...DemoData.categories.map((c) => _choice(c, category == c, () => setState(() => category = c))),
        ] else if (step == 2) ...[
          const _Card(child: SizedBox(height: 190, child: Center(child: Icon(Icons.map_outlined, size: 74, color: _primary)))),
          const SizedBox(height: 16),
          TextField(controller: locationController, decoration: const InputDecoration(labelText: 'الموقع المحدد')),
        ] else if (step == 3) ...[
          const Text('أضف وصفاً مختصراً يساعد القسم على فهم المشكلة.', style: TextStyle(color: _muted)),
          const SizedBox(height: 16),
          TextField(controller: descriptionController, maxLines: 5, decoration: const InputDecoration(hintText: 'اكتب وصف المشكلة...')),
        ] else if (step == 4) ...[
          _Card(child: Column(children: const [
            Icon(Icons.cloud_upload_outlined, color: _primary, size: 70),
            SizedBox(height: 16),
            Text('أرفق صورة توضح المشكلة', style: TextStyle(color: _navy, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('يمكنك اختيار صورة من المعرض أو التقاط صورة بالكاميرا', textAlign: TextAlign.center, style: TextStyle(color: _muted, fontSize: 12)),
          ])),
          const SizedBox(height: 14),
          OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined), label: const Text('التقاط صورة')),
          OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.photo_library_outlined), label: const Text('اختيار من المعرض')),
          const SizedBox(height: 12),
          const _Card(child: Text('سيتم استخدام الذكاء الاصطناعي للمساعدة في التحقق من فئة المشكلة بعد إضافة الصورة.', style: TextStyle(color: _muted, height: 1.5))),
        ] else ...[
          _Card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _summary('القسم', department ?? 'دائرة الأشغال العامة'),
            _summary('الفئة', category ?? 'حفرة في الشارع'),
            _summary('الموقع', locationController.text),
            _summary('الوصف', descriptionController.text),
            _summary('الصورة', 'لم تتم إضافة صورة فعلية — بيانات تجريبية'),
          ])),
          const SizedBox(height: 12),
          const Text('تأكد من صحة البيانات قبل إرسال البلاغ.', style: TextStyle(color: _muted)),
        ],
      ])),
      Padding(padding: const EdgeInsets.fromLTRB(24, 8, 24, 20), child: Row(children: [
        if (step > 0) Expanded(child: OutlinedButton(onPressed: () => setState(() => step--), child: const Text('السابق'))),
        if (step > 0) const SizedBox(width: 10),
        Expanded(flex: 2, child: _PrimaryButton(step == 5 ? 'إرسال البلاغ' : 'التالي', () {
          if (step == 5) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ReportSuccessScreen()));
          } else {
            setState(() => step++);
          }
        })),
      ])),
    ]),
  );

  Widget _choice(String text, bool selected, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: selected ? _primary : _border, width: selected ? 2 : 1)), child: Row(children: [Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, color: _primary), const SizedBox(width: 12), Expanded(child: Text(text, style: const TextStyle(color: _navy, fontWeight: FontWeight.w600)))])),
  );

  Widget _summary(String label, String value) => Padding(padding: const EdgeInsets.only(bottom: 14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: _muted, fontSize: 12)), const SizedBox(height: 4), Text(value, style: const TextStyle(color: _navy, fontWeight: FontWeight.bold))]));
}

class ReportSuccessScreen extends StatelessWidget {
  const ReportSuccessScreen({super.key});
  @override
  Widget build(BuildContext context) => _Page(
    title: 'تم إرسال البلاغ',
    showBack: false,
    child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const SizedBox(height: 60),
      const Icon(Icons.check_circle_outline, color: _primary, size: 100),
      const SizedBox(height: 26),
      const Text('تم إرسال بلاغك بنجاح', textAlign: TextAlign.center, style: TextStyle(color: _navy, fontSize: 23, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      const Text('تم استلام البلاغ وسيتم مراجعته من القسم المختص.', textAlign: TextAlign.center, style: TextStyle(color: _muted, height: 1.6)),
      const SizedBox(height: 28),
      _Card(child: Column(children: const [
        Text('رقم متابعة البلاغ', style: TextStyle(color: _muted)),
        SizedBox(height: 10),
        SelectableText(DemoData.trackingNumber, style: TextStyle(color: _primary, fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('احتفظ بالرقم لمتابعة حالة البلاغ', style: TextStyle(color: _muted, fontSize: 12)),
      ])),
      const Spacer(),
      _PrimaryButton('متابعة البلاغ', () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyReportsScreen()))),
      const SizedBox(height: 10),
      OutlinedButton(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashboardScreen()), (_) => false), child: const Text('العودة للرئيسية')),
    ])),
  );
}
