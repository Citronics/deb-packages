#!/bin/bash
# Keep only the newest builds of each experimental kernel series.
#
# Usage: prune-experimental.sh <pool/experimental> <kernel-assets.tsv> <pruned.txt> [keep]
#
# kernel-assets.tsv lists "<release date>\t<asset file name>" for every asset
# of every citronics-kernel release. A package's series is its kind (image or
# headers), its kernel major.minor and its phone, e.g. "linux-image 6.18 fp2".
# Per series the <keep> (default 3) packages from the newest releases stay;
# older ones are deleted and their names appended to pruned.txt, which the
# download step reads so that they are not downloaded again.
#
# A package whose release no longer exists counts as the oldest build of its
# series. Nothing outside the experimental pool is touched: release kernels in
# main stay available.
set -euo pipefail

POOL=$1
ASSETS=$2
PRUNED=$3
KEEP=${4:-3}

touch "$PRUNED"
list=$(mktemp)
for deb in "$POOL"/linux-image-*.deb "$POOL"/linux-headers-*.deb; do
	[ -f "$deb" ] || continue
	f=$(basename "$deb")
	date=$(awk -F'\t' -v f="$f" '$2 == f { print $1; exit }' "$ASSETS")
	date=${date:-0000-00-00T00:00:00Z}
	case "$f" in
		linux-image-*) kind=linux-image ;;
		*) kind=linux-headers ;;
	esac
	series=$(printf '%s' "$f" | sed -nE 's/^linux-(image|headers)-([0-9]+\.[0-9]+)\..*-lime-(fp[0-9]+).*/\2 \3/p')
	[ -n "$series" ] || continue
	printf '%s %s\t%s\t%s\n' "$kind" "$series" "$date" "$deb" >> "$list"
done

# Newest first within each series; everything past the first <keep> goes
sort -t "$(printf '\t')" -k1,1 -k2,2r "$list" |
	awk -F'\t' -v keep="$KEEP" '{ if (++n[$1] > keep) print $3 }' |
	while IFS= read -r deb; do
		echo "  pruned: $(basename "$deb")"
		basename "$deb" >> "$PRUNED"
		rm -f "$deb"
	done
rm -f "$list"
