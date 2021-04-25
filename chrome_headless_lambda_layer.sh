
RUNTIME=python3.7


SELENIUM_VER=3.141.0
CHROME_BINARY_VER=v1.0.0-55 # based on Chromium 69.0.3497.81
CHROMEDRIVER_VER=2.43       # supports Chrome v69-71

OUT_DIR=/out/build/chrome_headless/python/lib/$RUNTIME/site-packages

docker run -v $(pwd):/out -it lambci/lambda:build-$RUNTIME \
    pip install selenium==$SELENIUM_VER -t $OUT_DIR

cp chrome_headless.py build/chrome_headless/python/chrome_headless.py

pushd build/chrome_headless

DRIVER_URL=https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VER/chromedriver_linux64.zip
curl -SL $DRIVER_URL >chromedriver.zip
unzip chromedriver.zip
rm chromedriver.zip

# download chrome binary
CHROME_URL=https://github.com/adieuadieu/serverless-chrome/releases/download/$CHROME_BINARY_VER/stable-headless-chromium-amazonlinux-2017-03.zip
curl -SL $CHROME_URL >headless-chromium.zip
unzip headless-chromium.zip
rm headless-chromium.zip

zip -r ../../chrome_headless.zip *



