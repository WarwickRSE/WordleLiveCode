

# Note my original files have 2-char newlines and awk strips only the one part...
awk '{if(length($1)==6) print(substr($1, 1,5))}' words_alpha.txt > words_5.txt
