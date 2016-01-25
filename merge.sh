#!/bin/bash
#
# Merge pages from wikis into one

tempfile="tempfile.txt"
mwMaintDir="/opt/meza/htdocs/mediawiki/maintenance/"

if [ -f $tempfile ];
then
	rm ./tempfile.txt
	touch tempfile.txt
else
	touch tempfile.txt
fi

# $1 = page name
# $2 = from wiki
# $3 = to wiki
#
# Copy contents of "from wiki" page to tempfile
WIKI=$2 php ${mwMaintDir}getText.php $1 > tempfile.txt

# Append two line breaks to tempfile
printf '\n\n' >> tempfile.txt

# Append contents of "to wiki" page to tempfile
WIKI=$3 php ${mwMaintDir}getText.php $1 >> tempfile.txt

# Write contents of tempfile to "to wiki" page
cat tempfile.txt | WIKI=$3 php ${mwMaintDir}edit.php -u OscarRogers -s "Add content from $2 wiki" $1

