#!/bin/bash

posttemplate=$(cat "post-template.xml.dontchange")
webtemplate=$(cat "post-template.html.xml.dontchange")
fname="feed.xml"
pname="index.html"
read -p "Enter post title: " rssposttitle
read -p "Enter post author: " rsspostauthor
read -p "Press ENTER to use nano to enter post contents..."
randomfn="/tmp/post-content-$RANDOM"
nano $randomfn
rsspostcontent=$(cat $randomfn)

echo A1
rsspostdate=$(date -R)
echo A2
postfinal=$(echo "${posttemplate/post-title/$rssposttitle}")
wpostfinal=$(echo "${webtemplate/post-title/$rssposttitle}")
echo A3
postfinal=$(echo "${postfinal/post-author/$rsspostauthor}")
wpostfinal=$(echo "${wpostfinal/post-author/$rsspostauthor}")
echo A4
postfinal=$(echo "${postfinal/post-content/$rsspostcontent}")
wpostfinal=$(echo "${wpostfinal/post-content/$rsspostcontent}")
echo A5
postfinal=$(echo "${postfinal/post-date/$rsspostdate}")
wpostfinal=$(echo "${wpostfinal/post-date/$rsspostdate}")

oldcontent=$(cat $fname)
oldcontentwww=$(cat $pname)
echo "${oldcontent/'</channel>'/$postfinal}" > $fname
echo "${oldcontentwww/'</body>'/$wpostfinal}" > $pname

echo Done.
