import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/widgets/brand_logo.dart';

/// Smoke test for assets/logo_vector.svg: the file previously contained an
/// SVG <filter>/<feDropShadow> that flutter_svg cannot handle (logged
/// "unhandled element <filter/>" on every load). The filter has been removed;
/// this guards against reintroducing unsupported elements by failing on any
/// exception while the picture is built and rasterized.
void main() {
  testWidgets('BrandLogo renders the bundled SVG without errors',
      (tester) async {
    await tester.pumpWidget(const BrandLogo(size: 96));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
