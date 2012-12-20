#!/bin/sh

aFlag='';

while getopts 'a' o; do
	case $o in
		(a)	aFlag=yes;;
	esac
done

shift $(dc -e "$OPTIND 1 - p");

nFailed=0;

for x in "$@"; do
	found='';
	for d in $(echo "$PATH" | awk -v RS=: '{ print }'); do
		test -x "$d/$x" && found=yes && echo "$d/$x" && test -z "$aFlag" && break;
	done
	test -n "$found" || nFailed=$(dc -e "$nFailed 1 + p");
done

exit $nFailed;
