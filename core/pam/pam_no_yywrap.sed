/^%option noyywrap/ {
	:l0
	n
	bl0
}
/^%%$/ {
	i\
%option noyywrap\

	:l1
	n
	bl1
}
