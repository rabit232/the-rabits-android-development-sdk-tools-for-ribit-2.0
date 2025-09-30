# Ribit 2.0 Ubuntu Debian Android APK Makefile

.PHONY: help clean build-cordova build-python install-deps test lint

# Default target
help:
	@echo "Ribit 2.0 Ubuntu Debian Android APK Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  help           - Show this help message"
	@echo "  install-deps   - Install build dependencies"
	@echo "  build-cordova  - Build APK using Cordova"
	@echo "  build-python   - Build APK using Python/Buildozer"
	@echo "  build-all      - Build using all methods"
	@echo "  test           - Run tests and syntax checks"
	@echo "  lint           - Run code linting"
	@echo "  clean          - Clean build artifacts"
	@echo "  install        - Install APK to connected device"

# Install build dependencies
install-deps:
	@echo "Installing build dependencies..."
	sudo apt update
	sudo apt install -y openjdk-17-jdk nodejs npm python3-pip
	npm install -g cordova
	pip3 install -r requirements.txt

# Build APK using Cordova
build-cordova:
	@echo "Building APK using Cordova..."
	chmod +x build-debian-android-apk.sh
	./build-debian-android-apk.sh

# Build APK using Python/Buildozer
build-python:
	@echo "Building APK using Python/Buildozer..."
	buildozer android debug

# Build using all methods
build-all: build-cordova build-python

# Run tests and syntax checks
test:
	@echo "Running syntax checks..."
	bash -n ribit-debian-android-setup.sh
	bash -n build-debian-android-apk.sh
	python3 -m py_compile ribit-debian-android-app.py
	@echo "All syntax checks passed!"

# Run code linting
lint:
	@echo "Running code linting..."
	shellcheck ribit-debian-android-setup.sh build-debian-android-apk.sh || echo "shellcheck not installed"
	python3 -m flake8 ribit-debian-android-app.py --max-line-length=120 || echo "flake8 not installed"

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf .buildozer/
	rm -rf Ribit2DebianAndroid/
	rm -rf manual-apk/
	rm -f ribit-debian-android.apk
	rm -f *.pyc
	rm -rf __pycache__/

# Install APK to connected device
install:
	@echo "Installing APK to connected device..."
	@if [ -f "ribit-debian-android.apk" ]; then \
		adb install ribit-debian-android.apk; \
	elif [ -f "bin/ribitdebianandroid-1.0.0-debug.apk" ]; then \
		adb install bin/ribitdebianandroid-1.0.0-debug.apk; \
	else \
		echo "No APK found. Run 'make build-all' first."; \
	fi

# Development server (for testing web components)
serve:
	@echo "Starting development server..."
	python3 -m http.server 8000
