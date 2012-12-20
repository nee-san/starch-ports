#!/bin/ksh

xf=$(mktemp) || exit;

have_x="";

function qre {
	awk '
	BEGIN {
		FS = "";
		ORS = "|";
		OFS = "";
		meta = "|()[]{}^$?+*.\\";
	}
	{
		x = "";
		for (ii = 1; ii <= NF; ii++) {
			if (index (meta, $ii) == 0) x = x $ii;
			else x = x "\\" $ii;
		}
		print x;
	}
	' | sed 's/.$//'
}

while getopts "e:f:x" o; do
	case $o in
		(e)	echo -n "$OPTARG" | qre >$xf; have_x=yes;;
		(f)	cat     "$OPTARG" | qre >$xf; have_x=yes;;
		(x)	xFlag=yes;;
	esac
done

shift $(dc -e "$OPTIND 1 - p");

if test -z $have_x; then echo -n "$1" | qre >$xf; shift; fi

grep -E "$(if test -n "$xFlag"; then sed 's/^.*$/^&$/'; else cat; fi <$xf)" "$@"
