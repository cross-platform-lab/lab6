import 'question.dart';

// Quản lý danh sách câu hỏi và vị trí câu hỏi hiện tại.
class QuizBrain {
  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question('Một số con mèo bị dị ứng với con người.', true),
    Question('Bạn có thể dắt một con bò đi xuống cầu thang nhưng không thể dắt lên.', false),
    Question('Khoảng một phần tư xương người nằm ở bàn chân.', true),
    Question('Máu của ốc sên có màu xanh lá cây.', true),
    Question('Tổng diện tích bề mặt phổi người xấp xỉ bằng một sân tennis.', true),
    Question('Flutter do Google phát triển.', true),
    Question('Dart là ngôn ngữ chỉ chạy được trên trình duyệt web.', false),
    Question('Trong Flutter, mọi thứ đều là Widget.', true),
    Question('StatelessWidget có thể gọi setState() để cập nhật giao diện.', false),
    Question('Sông Mê Kông chảy qua 6 quốc gia.', true),
    Question('Thủ đô của Úc là Sydney.', false),
    Question('Ánh sáng từ Mặt Trời mất khoảng 8 phút để tới Trái Đất.', true),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() => _questionBank[_questionNumber].questionText;

  bool getCorrectAnswer() => _questionBank[_questionNumber].questionAnswer;

  int get questionNumber => _questionNumber + 1;

  int get totalQuestions => _questionBank.length;

  bool isFinished() => _questionNumber >= _questionBank.length - 1;

  void reset() {
    _questionNumber = 0;
  }
}
