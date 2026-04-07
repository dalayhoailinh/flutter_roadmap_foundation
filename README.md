# Flutter Roadmap Foundation

Dự án học Flutter theo lộ trình 2026 — Q1, Tháng 1.

## Kiến trúc

```
lib/
├── app/
│   ├── app.dart        # MaterialApp.router, ConsumerWidget
│   └── router.dart     # GoRouter với auth guard và ShellRoute
├── core/
│   └── constants/      # AppColors, AppTextStyles
└── features/
    ├── auth/           # AuthState enum, AuthNotifier, RouterNotifier, LoginPage
    ├── counter/        # Tuần 1: Entity, Repository, UseCase, Page
    ├── portfolio/      # Tuần 2–3: Layout Sliver, AsyncNotifier provider
    ├── shell/          # Tuần 4: AppShell với BottomNavigationBar
    └── watchlist/      # Tuần 3: StateNotifier provider, WatchlistPage
```

## Tính năng đã hoàn thành

| Tuần | Tính năng |
|------|-----------|
| 1    | Counter app – Clean Architecture (Entity / Repository / UseCase / Page) |
| 2    | Portfolio layout – CustomScrollView, SliverAppBar, SliverList |
| 3    | Riverpod state – StateNotifier (Watchlist), AsyncNotifier (Portfolio) |
| 4    | GoRouter navigation – Auth guard, ShellRoute, bottom nav, deep link ready |

## Chạy thử

```bash
flutter pub get
flutter run
```

Đăng nhập bằng nút "Đăng nhập (Demo)" — không cần tài khoản thật.

## Stack

- Flutter 3.x
- Dart 3.x
- flutter_riverpod ^3.3.1
- go_router ^17.2.0