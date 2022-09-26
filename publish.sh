NOW=`date '+%F_%H:%M'`;
git add .
git commit -m "$NOW"
git push
quarto publish gh-pages --no-prompt
