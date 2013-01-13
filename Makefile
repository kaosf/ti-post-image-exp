all: build install

# titanium CLI version is 3.0.22
build: FORCE
	titanium build -p android -b

# Android SDK is required
install: FORCE
	$(HOME)/local/bin/android-sdk-linux/platform-tools/adb -d install -r ./build/android/bin/app.apk

FORCE:

clean:
	titanium clean
