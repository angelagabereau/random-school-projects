#echo "starting....."

for file in *.txt; do
#	echo "concatenating ${file}..."
	cat $file >> store.index;
done;


echo "indexing...."

	# `sed` replaces non-word characters (spaces, punctuation...) by newlines, so each word is on its own line
	# `sort` sorts these lines alphabetically
	# `uniq` keeps a single copy of each duplicate line and keeps a count of how many times it occurs; that's your index
	# `sed` transforms the .txt filename into a .index filename
	#cat $file | sed -e 's/\W/\n/g' | sort | uniq -c > $(echo $file | sed -e 's/\.txt/\.index/');
	#cat index.index | tr -sc '[A-Z][a-z]' '[\012*]' | sort | uniq -c > $(echo index.index);

cat store.index | tr -sc '[A-Z][a-z]' '[\012*]' | tr '[ \] ]' '[\012*]' | tr '[ \[ ]' '[\012*]' | tr '[A-Z]' '[a-z]' | sort | uniq -c | sort -nr > index.index;
cat store.index | tr -sc '[A-Z][a-z]' '[\012*]' | tr '[ \] ]' '[\012*]' | tr '[ \[ ]' '[\012*]' | tr '[A-Z]' '[a-z]' | sort | uniq -c > alpha_index.index;


sort index.index -n > nindex.index