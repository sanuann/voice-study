#!/bin/bash

set -e # exit with nonzero exit code if anything fails

if [[ $TRAVIS_BRANCH == "master" && $TRAVIS_PULL_REQUEST == "false" ]]; then

echo "Starting to update gh-pages\n"

#copy data we're interested in to other place
cp -R dist $HOME/dist

#go to home and setup git
cd $HOME
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis"

#using token clone gh-pages branch
git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/${GH_USER}/${GH_REPO}.git gh-pages > /dev/null

#go into directory and copy data we're interested in to that directory
cd gh-pages
cp -Rf $HOME/dist/* .

echo "Allow files with underscore https://help.github.com/articles/files-that-start-with-an-underscore-are-missing/" > .nojekyll
echo "[View live](https://${GH_USER}.github.io/${GH_REPO}/)" > README.md

#add, commit and push files
git add -f .
git commit -m "Travis build $TRAVIS_BUILD_NUMBER"
git push -fq origin gh-pages > /dev/null

echo "Done updating gh-pages\n"

else if [[ $TRAVIS_BRANCH == "expose-all-questions" && $TRAVIS_PULL_REQUEST == "false" ]]; then

 echo "Starting to update gh-pages from feature branch\n"

 #create a folder named after the branch
 mkdir expose-all-questions

#go into directory and copy data we're interested in to that directory
 cd expose-all-questions
 cp -Rf $HOME/dist/* .

 #go to home and setup git
 cd $HOME
 git config --global user.email "travis@travis-ci.org"
 git config --global user.name "Travis"

 #using token clone gh-pages branch
 git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/${GH_USER}/${GH_REPO}.git gh-pages > /dev/null

 echo "Allow files with underscore https://help.github.com/articles/files-that-start-with-an-underscore-are-missing/" > .nojekyll
 echo "[View live](https://${GH_USER}.github.io/${GH_REPO}/)" > README.md

 #add, commit and push files
 git add -f .
 git commit -m "Travis build $TRAVIS_BUILD_NUMBER"
 git push -fq origin gh-pages > /dev/null

 echo "Done updating gh-pages with build triggered from feature branch\n"

fi;
