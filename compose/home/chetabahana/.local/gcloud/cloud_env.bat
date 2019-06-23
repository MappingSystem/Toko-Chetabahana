ECHO OFF
CLS
SET Prompt=$$
SET PATH=C:\UnxUtils\usr\local\wbin;%PATH%;
SET PATH=C:\Program Files\Google\Cloud SDK\google-cloud-sdk\bin;%PATH%;
SET PATH=C:\Users\Chetabahana\AppData\Local\Programs\Python\Python37-32\;%PATH%;
SET PATH=C:\Users\Chetabahana\AppData\Local\Programs\Python\Python37-32\Scripts;%PATH%;
SET PATH=C:\Program Files\Google\Cloud SDK\google-cloud-sdk\platform\google_appengine;%PATH%;

SET PROJECT=C:\Users\Chetabahana\Project\Google\GAE\python\celery
ECHO Google Cloud SDK! Run "gcloud -h" to get available commands.

CD %PROJECT%
pwd

git fetch origin
REM SET count=`git rev-list HEAD...upstream/master --count`
git reset --hard origin/master

SET date=%DATE:~0,2%
SET hour=%TIME:~0,2%
SET minute=%TIME:~3,2%
IF "%date:~0,1%"==" " SET date=0%DATE:~1,1%
IF "%hour:~0,1%"==" " SET hour=0%TIME:~1,1%
IF "%minute:~0,1%"==" " SET minute=0%TIME:~1,1%
SET VERSION=%date%%hour%%minute%
sed -e "s/-[0-9]\{1,\}-\([a-zA-Z0-9_]*\)'/-%VERSION%-local'/g" cloudbuild.yaml > tmp.txt 
mv -f tmp.txt cloudbuild.yaml

git status
git add .
git commit -m "local commit"
git push -u origin master

findstr "\<version.*" cloudbuild.yaml | sed "s/  args: \['app', 'deploy', /SERVING: \[/g"

REM tutorial-env\Scripts\activate.bat
ECHO ---
ECHO ON
