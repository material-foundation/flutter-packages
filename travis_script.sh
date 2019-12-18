set -e

# Backs up one directory at a time, looking for one called "flutter".
function getFlutterPath() {
    local path=".."
    local counter=0

    while [[ "${counter}" -lt 10 ]]; do
        [ -d "${path}/flutter" ] && echo "${path}/flutter" && return 0
        let counter++
        path="${path}/.."
    done
}

echo "== Testing on Flutter's $FLUTTER_VERSION channel =="

localSdkPath=$(getFlutterPath)

if [ -z "$localSdkPath" ]
then
    echo "Failed to find Flutter SDK."
    exit 1
fi

# Run the analyzer to find any static analysis issues.
"${localSdkPath}/bin/flutter" analyze

# Run the formatter on all the dart files to make sure everything's linted.
"${localSdkPath}/bin/flutter" format -n --set-exit-if-changed .

# Run the actual tests.
"${localSdkPath}/bin/flutter" test

echo "-- Success --"