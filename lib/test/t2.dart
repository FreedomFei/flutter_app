String screem(int length) => 'A${'a' * length} h!';

main() {
  final values = [1, 2, 3, 5, 10];

  values.skip(1).take(4).map(screem).forEach(print);
}
