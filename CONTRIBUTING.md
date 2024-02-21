# Contributing

[![Checks](https://github.com/material-foundation/flutter-packages/actions/workflows/checks.yml/badge.svg?branch=main)](https://github.com/material-foundation/flutter-packages/actions/workflows/checks.yml)
[![ossf scorecard](https://img.shields.io/ossf-scorecard/github.com/material-foundation/flutter-packages?label=openssf%20scorecard&style=flat)](https://api.securityscorecards.dev/projects/github.com/material-foundation/flutter-packages)

Thank you for your interest in contributing! Your work can help many developers.

## Updating an existing package
> **Note**
> All packages target Flutter's beta channel

### Development

1.  Fork the repo and clone it to your local machine, creating a branch to work on.
1.  Make the changes.
1.  If there exists an example app under `/example`, use it to manually test your changes.
1.  Write a unit test for your change, under `test/`.
1.  Update the `CHANGELOG.md` using [`cider`](https://pub.dev/packages/cider). For example:
    ```
    cider log changed|added|fixed|removed 'Added a schmilblick'
    ```
1.  Make sure all the existing tests are passing with `flutter test`.
1.  Make sure the repo is formatted using `dart format .`.
1.  Commit the changes to your branch and push.

That's it! Releasing is done by team members, see the [Releasing](#releasing) section below.

### Review

1.  Create a PR to merge your branch into `flutter-packages/main`.
1.  A reviewer will be automatically assigned.

### Releasing

> **Note**
> For [package maintainers](https://github.com/orgs/material-foundation/teams/material-flutter-package-maintainers) only

> **Tip**
> To run a command for all subpackages, use `for d in ./packages/*; do (cd "$d" && <command>); done`

1. Bump `pubspec.yaml`'s `version` with:
    ```
    cider bump major|minor|patch
    ```
1. Update the `CHANGELOG.md` with:
    ```
    cider release
    ```

1. Publish to [pub.dev](https://pub.dev/publishers/material.io/packages) with:
    ```
    flutter pub publish
    ```
1. Create and push a commit and tag
    ```
    git commit -am "bump \`$(basename $PWD)\` to $(cider version)"
    git tag "$(basename $PWD)-$(cider version)"
    git push --all
    ```

## Adding a new package
New packages should be accounted for in:
- [`.github/dependabot.yml`](.github/dependabot.yml)
- [`.github/ISSUE_TEMPLATE/bug_report.yml`](.github/ISSUE_TEMPLATE/bug_report.yml)
- [`.github/ISSUE_TEMPLATE/feature_request.yml`](.github/ISSUE_TEMPLATE/feature_request.yml)
- [`.github/labeler.yml`](.github/labeler.yml)
- [`.github/workflows/checks.yml`](.github/workflows/checks.yml)
