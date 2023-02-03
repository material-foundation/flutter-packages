# Contributing

[![Checks](https://github.com/material-foundation/flutter-packages/actions/workflows/checks.yml/badge.svg?branch=main)](https://github.com/material-foundation/flutter-packages/actions/workflows/checks.yml)
[![Release Status](https://github.com/material-foundation/flutter-packages/actions/workflows/release.yml/badge.svg)](https://github.com/material-foundation/flutter-packages/actions/workflows/publish.yml)
TODO(guidezpl): fix us
[![ossf scorecard](https://img.shields.io/ossf-scorecard/github.com/material-foundation/flutter-packages?label=openssf%20scorecard&style=flat)](https://api.securityscorecards.dev/projects/github.com/material-foundation/flutter-packages)

## Welcome

Thank you for your interest in contributing! Your work can help many developers.

## Updating an existing package

### Development

1.  Fork the repo and clone it to your local machine, creating a branch to work on.
1.  Make the changes.
1.  If there exists an example app under `/example`, use it to manually test your changes.
1.  Write a unit test for your change, under `test/`.
1.  Update the `CHANGELOG.md` using [`cider`](https://pub.dev/packages/cider). For example:
    ```
    cider log changed|added|fixed|removed 'Did this and that'
    ```
1.  Make sure all the existing tests are passing with `flutter test`.
1.  Make sure the repo is formatted using `flutter format .`.
1.  Commit the changes to your branch and push.

That's it! Releasing is done by team members, see the [Releasing](#releasing) section below.

### Review

1.  Create a PR to merge your branch into `flutter-packages/main`.
1.  A reviewer will be automatically assigned.

### Releasing

1. Bump the pubspec version with:
    ```
    cider bump major|minor|patch
    ```
2. Update the CHANGELOG.md, commit, and tag the changes with:
    ```
    cider release
    git commit -am "bump \`$(basename $PWD)\` to $(cider version)"
    git tag "$(basename $PWD)-$(cider version)"
    ```

5. Push the commit and tag with:
    ```
    git push --all
    ```

Done! The [`publish.yml`](https://github.com/material-foundation/flutter-packages/blob/main/.github/workflows/publish.yml) workflow will pick up on the tag and take care of publishing the package to pub.dev.

## New packages
New packages should be accounted for in:
- [`.github/dependabot.yml`](.github/dependabot.yml)
- [`.github/ISSUE_TEMPLATE/bug_report.yml`](.github/ISSUE_TEMPLATE/bug_report.yml)
- [`.github/ISSUE_TEMPLATE/feature_request.yml`](.github/ISSUE_TEMPLATE/feature_request.yml)
- [`.github/labeler.yml`](.github/workflows/labeler.yml)
- [`.github/workflows/checks.yml`](.github/workflows/checks.yml)
