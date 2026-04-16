# Flutter Roadmap Foundation

[![Flutter CI](https://github.com/<your-username>/<your-repo>/actions/workflows/ci.yml/badge.svg)](https://github.com/<your-username>/<your-repo>/actions/workflows/ci.yml)

App trading Fintech demo được build trong Q1 roadmap 2026 (đã hoàn thành đến Tuần 10). Tích hợp:
- Riverpod state management với StreamProvider và StateNotifier
- GoRouter với ShellRoute và auth redirect guard
- CustomPainter candlestick chart với realtime tick aggregation
- GitHub Actions CI: analyze → test → build APK tự động

## Kiến trúc

```
lib/
├── app/
│   ├── app.dart        # MaterialApp.router + ProviderScope
│   └── router.dart     # GoRouter với auth guard và ShellRoute
├── core/
│   ├── animations/     # Hằng số animation
│   ├── constants/      # AppColors, AppTextStyles
│   └── widgets/        # Widget dùng chung như LoadingOverlay
└── features/
    ├── auth/           # AuthState enum, AuthNotifier, RouterNotifier, LoginPage
    ├── counter/        # Tuần 1: Entity, Repository, UseCase, Page
    ├── market/         # Stream, isolate, chart, candlestick, freezed model
    ├── native/         # Tuần 11: Dart FFI (native_math_ffi.dart) + Platform Channel (device_channel.dart)
    ├── portfolio/      # Riverpod async state + portfolio layout
    ├── shell/          # AppShell với BottomNavigationBar
    └── watchlist/      # StateNotifier provider, WatchlistPage
```

## Tính năng đã hoàn thành

| Tuần | Tính năng |
|------|-----------|
| 1    | Counter app – Clean Architecture (Entity / Repository / UseCase / Page) |
| 2    | Portfolio layout – CustomScrollView, SliverAppBar, SliverList |
| 3    | Riverpod state – StateNotifier (Watchlist), AsyncNotifier (Portfolio) |
| 4    | GoRouter navigation – Auth guard, ShellRoute, bottom nav, deep link ready |
| 5    | Dart async – Stream, isolate, luồng dữ liệu thị trường realtime |
| 6    | Animation – Loading UI và spinner/pulse cho trải nghiệm thị trường |
| 7    | CustomPaint – Candlestick chart thủ công bằng Canvas API |
| 8    | Code generation – `build_runner`, `freezed`, `CandleData` value equality |
| 9    | Git nâng cao + CI/CD cơ bản – rebase/cherry-pick practice, GitHub Actions analyze/test/build APK |
| 10   | Flutter Web + deploy – build web và deploy production |
| 11   | Dart FFI + Platform Channel – Native code interop (C via FFI, Kotlin via MethodChannel) |

## Checkpoint hiện tại

- Auth flow demo vẫn chạy bằng nút "Đăng nhập (Demo)", không cần tài khoản thật.
- Market page có stream giá realtime, isolate demo và chart page riêng cho từng ticker.
- Candlestick chart được tự vẽ bằng `CustomPainter`, không dùng thư viện chart ngoài.
- `CandleData` đã migrate sang `freezed` để so sánh theo value thay vì reference.
- CI/CD qua GitHub Actions đã chạy analyze + test + build APK artifact.
- Web app đã deploy production (Vercel).
- **Week 11:** Dart FFI (C function binding) + Platform Channel (MethodChannel Kotlin) hoàn tất. Demo gọi C function tính sum via FFI, và lấy device info via MethodChannel.

## Chạy thử

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

Chạy bản web local:

```bash
flutter run -d chrome
```

Đăng nhập bằng nút "Đăng nhập (Demo)" — không cần tài khoản thật.

## Stack

- Flutter 3.x
- Dart 3.x
- flutter_riverpod ^3.3.1
- go_router ^17.2.0
- freezed + build_runner
- CustomPaint / Canvas API

## Chạy test

```bash
flutter test
```

## CI/CD

Mỗi push lên `master` tự động:
1. `flutter analyze` — kiểm tra lỗi tĩnh
2. `flutter test` — chạy toàn bộ test suite
3. Build APK release — artifact có thể download từ tab Actions

## Tiến độ Roadmap

- Đã hoàn thành: Tuần 1 -> Tuần 11 (Q1 + Week 11 native interop)
- Đang hướng tới: Tuần 12+ (Rust via flutter_rust_bridge trong Q2)

## 🌐 Demo Live

**Web:** https://flutter-roadmap-foundation-xxx.vercel.app

## Tài liệu thêm

- Lịch sử GitHub từ commit đầu tiên đến hiện tại: [GITHUB_HISTORY.md](GITHUB_HISTORY.md)
- Snapshot toàn bộ code trong lib: [full_code.md](full_code.md)