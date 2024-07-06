part of 'page.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key});
  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _milliSeconds = 0;
  Timer? _timer;
  bool _isTimerRunning = false;
  late DateTime _startTime;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (_isTimerRunning) return;
    _startTime = DateTime.now();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        final now = DateTime.now();
        _milliSeconds = now.difference(_startTime).inMilliseconds;
      });
    });

    setState(() {
      _isTimerRunning = true;
    });
  }

  void stopTimer() {
    if (!_isTimerRunning) return;
    _startTime = DateTime.timestamp();
    _timer?.cancel();
    setState(() {
      final now = DateTime.timestamp();
      _isTimerRunning = false;
    });
  }

  void resetTimer() {
    if (!_isTimerRunning) return;
    _timer?.cancel();
    setState(() {
      _milliSeconds = 0;
      _isTimerRunning = false;
    });
  }

  String getFormattedTime() {
    int totalSeconds = _milliSeconds ~/ 1000;
    int mSeconds = _milliSeconds % 1000 ~/ 12;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${mSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    String formattdTime = getFormattedTime();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Stop',
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                  Text(
                    'Watch',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  )
                ],
              ),
            ),
            Stack(alignment: Alignment.center, children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.all(8.0),
                height: 80,
                decoration: BoxDecoration(
                    color: mainColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12)),
              ),
              Text(
                formattdTime,
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
            ]),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !_isTimerRunning
                    ? ElevatedButton(
                        onPressed: startTimer,
                        child: Text('Start'),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: stopTimer,
                        child: Text(
                          'Stop',
                          style: TextStyle(color: Colors.white),
                        )),
                ElevatedButton(
                    onPressed: !_isTimerRunning ? null : resetTimer,
                    child: Text('Reset'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
