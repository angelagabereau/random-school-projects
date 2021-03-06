#!/bin/bash
# Finding Out About downloader, tag-stripper and indexer
# by Julien Dubuc, 2007

# get the files from the website.
wget -r http://www-cse.ucsd.edu/~rik/foa/l2h/;

# go into the directory created by wget
cd www-cse.ucsd.edu/~rik/foa/l2h/;

# only consider files from chapters 1, 2, 3, 4 and 6
for i in 1 2 3 4 6; do

	# filenames look line foa-<chapter>-<section>-<subsection>.html
	for file in foa-${i}*.html; do

		# progress indicator
		echo "stripping ${file}..."

		# `sed` strips HTML tags from the file, then
		# `sed` transform the .html filename into a .txt filename
		cat $file | sed -e 's/<[^>]*>//g' > $(echo $file | sed -e 's/\.html/\.txt/');
	done;
done;

# return to the directory where the script is
cd ../../../..;

# make a directory for the text files, and put the text files in it
mkdir index;
mv www-cse.ucsd.edu/~rik/foa/l2h/*.txt index/

# remove the website copy
rm -rf www-cse.ucsd.edu/

# build the index
cd index;



for file in *.txt; do

	# progress indicator
	echo "indexing ${file}..."

	# `sed` replaces non-word characters (spaces, punctuation...) by newlines, so each word is on its own line
	# `sort` sorts these lines alphabetically
	# `uniq` keeps a single copy of each duplicate line and keeps a count of how many times it occurs; that's your index
	# `sed` transforms the .txt filename into a .index filename
	#cat $file | sed -e 's/\W/\n/g' | sort | uniq -c > $(echo $file | sed -e 's/\.txt/\.index/');
	cat $file | tr -sc '[A-Z][a-z]' '[\012*]' | sort | uniq -c > $(echo $file | sed -e 's/\.txt/\.index/');
done;

