NOW=`date '+%F_%H:%M'`;
quarto render
git add .
git commit -m "$NOW"
git push
#quarto publish gh-pages --no-prompt
