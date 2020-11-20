Contributing to the google_fonts package.
=========================================

Thank you for your interest in contributing to the `google_fonts` package! We love receiving 
contributions, and your work helps the whole community. This doc will walk you through the easiest 
way to make a change and have it submitted to the `google_fonts` package.

Developer workflow
------------------
sdjfkalfjklsadfaversion number, and a description of the change you're 
 making.
 1. Update the `version:` in the `pubspec.yaml` file to your new version.
 
### Review
 1. Make sure all the existing tests are passing by using the following command (from the root of 
 the project): `$ flutter test test/`.
 1. Make sure the repo is formatted using `$ flutter format .`.
 1. Create a PR to merge the branch on your fork into `google-fonts-flutter/master`.
 1. Add `johnsonmh` and `clocksmith` as reviewers on the PR. We will take a look and add any 
 comments. When the PR is ready to be merged, we will merge it and update the package on 
 [pub.dev](https://pub.dev/packages/google_fonts)! 
 
Updating the fonts
------------------

If you notice fonts that are on [fonts.google.com](https://fonts.google.com) that do not appear in 
this package, it means that the generator needs to be run.

Running the generator is easy, and are happy to accept PRs with new fonts.

To do this, navigate to the root of the project, and run `dart generator/generator.dart`. It will 
check [fonts.google.com](https://fonts.google.com) for any new fonts, manually test each URL, and 
regenerate the dart code. 

After running the script, update the `version:` number in `pubspec.yaml`, and add the new version 
to the `CHANGELOG.md` file, specifying that the package was updated to include new fonts.
