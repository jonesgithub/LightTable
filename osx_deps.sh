#get the LightTable.app binary
curl -O http://d35ac8ww5dfjyg.cloudfront.net/playground/bins/0.6.0/LightTableMac.zip
unzip LightTableMac.zip
mv LightTable/* deploy/
rmdir LightTable/
rm LightTableMac.zip

#build the core cljs of LightTable
lein cljsbuild clean && lein cljsbuild once

#Get the plugins from the binary
cd deploy
mv LightTable.app/Contents/Resources/app.nw/plugins plugins
cd plugins

#Make sure we have the latest clojure
rm -rf clojure
git clone https://github.com/LightTable/Clojure.git clojure
cd clojure
./build.sh

#Remove the app.nw so we use our local copy
cd ../../
rm -rf LightTable.app/Contents/Resources/app.nw
#Set this as home and run
export LT_HOME=$(pwd)
