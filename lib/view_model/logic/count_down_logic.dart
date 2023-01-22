class CountDownLogic {
  countDownTimer() async {
    await Future.delayed(const Duration(milliseconds: 100)); //音鳴らすロ
  }
  countDownTimer1() async {
    await Future.delayed(const Duration(seconds: 1)); //音鳴らすロ
  }
}
