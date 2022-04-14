# Team Visual

A Flutter project that includes courses from the users.

:white_check_mark: 100% Dart.

:white_check_mark: Clean Architecture.

:white_check_mark: MVVM and Repository pattern.

:white_check_mark: Floor as local database.

:white_check_mark: Stacked from state management.

## Main Packages

This project includes several packages, the main ones are:

-  [stacked](https://pub.dev/packages/stacked): A architecture based in MVVM.

-  [get_it](https://pub.dev/packages/get_it): Service locator to dependency injection.

-  [http](https://pub.dev/packages/http): To consume http recourses.

-  [flutter_screenutil](https://pub.dev/packages/flutter_screenutil): To make responsive screens.

-  [floor](https://pub.dev/packages/floor): Local database similar to Room.

-  [video_player](https://pub.dev/packages/video_player): For playing videos to the users.

-  [geolocator](https://pub.dev/packages/geolocator): To get users location.

## Considerations

- Register downloadable resources (word, excel, video) with extensions (.docx, .xls, .mp4)

- When changes are made to the local db (dao, entities, etc.), run the command:

    flutter packages pub run build_runner build --delete-conflicting-outputs
