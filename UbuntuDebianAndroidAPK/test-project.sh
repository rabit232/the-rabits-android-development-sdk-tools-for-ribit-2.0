#!/bin/bash

# Ribit 2.0 Ubuntu Debian Android APK Test Script
# Comprehensive testing and validation of all project components

set -e

# Colors for output
C_RED='\033[0;31m'
C_GREEN='\033[0;32m'
C_YELLOW='\033[1;33m'
C_BLUE='\033[0;34m'
C_RESET='\033[0m'

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_TOTAL=0

# Test result function
test_result() {
    local test_name="$1"
    local result="$2"
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    
    if [ "$result" = "0" ]; then
        echo -e "${C_GREEN}✅ PASS${C_RESET} - $test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${C_RED}❌ FAIL${C_RESET} - $test_name"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

echo -e "${C_BLUE}🧪 Ribit 2.0 Ubuntu Debian Android APK Test Suite${C_RESET}"
echo "=================================================="

# Test 1: File existence
echo -e "\n${C_YELLOW}📁 Testing file existence...${C_RESET}"

test_files=(
    "ribit-debian-android-setup.sh"
    "build-debian-android-apk.sh"
    "ribit-debian-android-app.py"
    "main.py"
    "buildozer.spec"
    "requirements.txt"
    "Makefile"
    "LICENSE"
    "README.md"
    "INSTALLATION_INSTRUCTIONS.md"
    "CHANGELOG.md"
    "assets/icons/icon.png"
    "assets/presplash.png"
    "assets/ribit-launcher.desktop"
)

for file in "${test_files[@]}"; do
    if [ -f "$file" ]; then
        test_result "File exists: $file" 0
    else
        test_result "File exists: $file" 1
    fi
done

# Test 2: Script syntax validation
echo -e "\n${C_YELLOW}📝 Testing script syntax...${C_RESET}"

if bash -n ribit-debian-android-setup.sh 2>/dev/null; then
    test_result "Setup script syntax" 0
else
    test_result "Setup script syntax" 1
fi

if bash -n build-debian-android-apk.sh 2>/dev/null; then
    test_result "Build script syntax" 0
else
    test_result "Build script syntax" 1
fi

if bash -n test-project.sh 2>/dev/null; then
    test_result "Test script syntax" 0
else
    test_result "Test script syntax" 1
fi

# Test 3: Python syntax validation
echo -e "\n${C_YELLOW}🐍 Testing Python syntax...${C_RESET}"

if python3 -m py_compile ribit-debian-android-app.py 2>/dev/null; then
    test_result "Python app syntax" 0
else
    test_result "Python app syntax" 1
fi

# Test 4: File permissions
echo -e "\n${C_YELLOW}🔐 Testing file permissions...${C_RESET}"

if [ -x "ribit-debian-android-setup.sh" ]; then
    test_result "Setup script executable" 0
else
    test_result "Setup script executable" 1
fi

if [ -x "build-debian-android-apk.sh" ]; then
    test_result "Build script executable" 0
else
    test_result "Build script executable" 1
fi

if [ -x "test-project.sh" ]; then
    test_result "Test script executable" 0
else
    test_result "Test script executable" 1
fi

# Test 5: Configuration validation
echo -e "\n${C_YELLOW}⚙️ Testing configuration files...${C_RESET}"

# Check buildozer.spec
if grep -q "title = Ribit 2.0 Debian Android" buildozer.spec; then
    test_result "Buildozer title configuration" 0
else
    test_result "Buildozer title configuration" 1
fi

if grep -q "package.name = ribitdebianandroid" buildozer.spec; then
    test_result "Buildozer package name" 0
else
    test_result "Buildozer package name" 1
fi

if grep -q "requirements = python3,kivy,pyjnius" buildozer.spec; then
    test_result "Buildozer requirements" 0
else
    test_result "Buildozer requirements" 1
fi

# Test 6: Asset validation
echo -e "\n${C_YELLOW}🎨 Testing assets...${C_RESET}"

if [ -f "assets/icons/icon.png" ] && file assets/icons/icon.png | grep -q "PNG image"; then
    test_result "App icon format" 0
else
    test_result "App icon format" 1
fi

if [ -f "assets/presplash.png" ] && file assets/presplash.png | grep -q "PNG image"; then
    test_result "Presplash format" 0
else
    test_result "Presplash format" 1
fi

# Test 7: Documentation validation
echo -e "\n${C_YELLOW}📚 Testing documentation...${C_RESET}"

if grep -q "Ribit 2.0" README.md; then
    test_result "README contains project name" 0
else
    test_result "README contains project name" 1
fi

if grep -q "Installation" INSTALLATION_INSTRUCTIONS.md; then
    test_result "Installation instructions present" 0
else
    test_result "Installation instructions present" 1
fi

if grep -q "MIT License" LICENSE; then
    test_result "License file format" 0
else
    test_result "License file format" 1
fi

# Test 8: Script content validation
echo -e "\n${C_YELLOW}🔍 Testing script content...${C_RESET}"

if grep -q "proot-distro" ribit-debian-android-setup.sh; then
    test_result "Setup script contains proot-distro" 0
else
    test_result "Setup script contains proot-distro" 1
fi

if grep -q "cordova" build-debian-android-apk.sh; then
    test_result "Build script contains cordova" 0
else
    test_result "Build script contains cordova" 1
fi

if grep -q "kivy" ribit-debian-android-app.py; then
    test_result "Python app uses Kivy" 0
else
    test_result "Python app uses Kivy" 1
fi

# Test 9: Dependency validation
echo -e "\n${C_YELLOW}📦 Testing dependencies...${C_RESET}"

# Check if required commands exist
commands=("python3" "bash" "make")
for cmd in "${commands[@]}"; do
    if command -v "$cmd" >/dev/null 2>&1; then
        test_result "Command available: $cmd" 0
    else
        test_result "Command available: $cmd" 1
    fi
done

# Test 10: Integration validation
echo -e "\n${C_YELLOW}🔗 Testing integration...${C_RESET}"

# Check if main.py links to the correct file
if [ -L "main.py" ] && [ "$(readlink main.py)" = "ribit-debian-android-app.py" ]; then
    test_result "main.py symbolic link" 0
else
    test_result "main.py symbolic link" 1
fi

# Check if Makefile has required targets
required_targets=("help" "build-cordova" "build-python" "test" "clean")
for target in "${required_targets[@]}"; do
    if grep -q "^$target:" Makefile; then
        test_result "Makefile target: $target" 0
    else
        test_result "Makefile target: $target" 1
    fi
done

# Test 11: Security validation
echo -e "\n${C_YELLOW}🔒 Testing security...${C_RESET}"

# Check for hardcoded passwords or keys (exclude legitimate prompts and documentation)
suspicious_secrets=$(grep -r "password\|key\|secret" --include="*.py" --include="*.sh" . | grep -v -E "(read -s|password.*input|password.*prompt|password.*enter|password.*create|password.*for|adduser.*password|key.*word|secret.*ory|VNC password|username and password|Check for hardcoded|test_result)" | grep -E "password.*=|key.*=|secret.*=" || true)

if [ -z "$suspicious_secrets" ]; then
    test_result "No hardcoded secrets" 0
else
    test_result "No hardcoded secrets" 1
    echo "Suspicious entries found: $suspicious_secrets"
fi

# Check file permissions are not too permissive
if ! find . -type f -perm -o+w | grep -v ".git"; then
    test_result "File permissions secure" 0
else
    test_result "File permissions secure" 1
fi

# Test Results Summary
echo -e "\n${C_BLUE}📊 Test Results Summary${C_RESET}"
echo "======================="
echo -e "Total Tests: ${C_BLUE}$TESTS_TOTAL${C_RESET}"
echo -e "Passed: ${C_GREEN}$TESTS_PASSED${C_RESET}"
echo -e "Failed: ${C_RED}$TESTS_FAILED${C_RESET}"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "\n${C_GREEN}🎉 All tests passed! Project is ready for deployment.${C_RESET}"
    exit 0
else
    echo -e "\n${C_RED}⚠️ Some tests failed. Please review and fix issues before deployment.${C_RESET}"
    exit 1
fi
