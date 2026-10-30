#!/usr/bin/env bash
# Build isolated packages as a normal user. Never installs or touches user configs.
set -euo pipefail
umask 022
here="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if [[ ${EUID} == 0 ]]; then
    echo 'Run builds as a normal user, not root.' >&2
    exit 1
fi
if [[ ${1:-} == --list ]]; then
    exec python3 -c 'import json,sys; print("\n".join(json.load(open(sys.argv[1]))))' "$here/packages.json"
fi
reuse=
if [[ ${1:-} == --reuse-from ]]; then
    reuse="$(realpath "$2")"
    shift 2
fi
python3 -B -m unittest discover -s "$here/tests" -v
mapfile -t packages < <("$0" --list)
if [[ $# -gt 0 && $1 != all ]]; then
    packages=("$@")
fi
for package in "${packages[@]}"; do
    python3 "$here/prepare-source.py" "$package"
    directory="$here/build/$package"
    mapfile -t archives < <(cd "$directory" && makepkg --packagelist)
    [[ ${#archives[@]} == 1 ]] || { echo "Expected one output for $package" >&2; exit 1; }
    archive="${archives[0]}"
    fingerprint="${archive##*/}.source.sha256"
    if [[ -n $reuse && -f "$reuse/${archive##*/}" ]]; then
        if ! cmp -s "$directory/source.sha256" "$reuse/$fingerprint"; then
            echo "$package changed without a version bump. Increment pkgver/pkgrel in its PKGBUILD." >&2
            exit 1
        fi
        cp "$reuse/${archive##*/}" "$archive"
        [[ ! -f "$reuse/${archive##*/}.sig" ]] || cp "$reuse/${archive##*/}.sig" "$archive.sig"
    else
        (cd "$directory" && makepkg --cleanbuild --nodeps --force)
    fi
    cp "$directory/source.sha256" "${archive%/*}/$fingerprint"
done
