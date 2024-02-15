import '../../main.dart' as runner;
import '../flavors.dart';

Future<void> main() async {
  F.appFlavor = Flavor.development;
  await runner.main();
}
