# Check node, npm, pnpm and butler-ci-cli installation

echo "Checking installations..."
# Check Node.js installation
if ! command -v node &> /dev/null; then
    echo "Node.js is not installed. Please install it first."
    exit 1
else
    echo "Node.js is installed: $(node -v)"
fi
# Check npm installation
if ! command -v npm &> /dev/null; then
    echo "npm is not installed. Please install it first."
    exit 1
else
    echo "npm is installed: $(npm -v)"
fi

# (Optionally) Check pnpm installation
if ! command -v pnpm &> /dev/null; then
    echo "pnpm is not installed. Using npm to install butler-ci-cli."
    INSTALLER="npm"
else
    echo "pnpm is installed: $(pnpm -v)"
    INSTALLER="pnpm"
fi

# Check butler-ci-cli installation. If installed do nothing
if command -v butler-ci-cli &> /dev/null; then
    echo "butler-ci-cli is already installed: $(butler-ci-cli --version)"
    exit 0
else
    echo "butler-ci-cli is not installed. Proceeding with installation..."
    $INSTALLER install -g butler-ci-cli
    if command -v butler-ci-cli &> /dev/null; then
        echo "butler-ci-cli installed successfully: $(butler-ci-cli --version)"
        exit 0
    else
        echo "Failed to install butler-ci-cli."
        exit 1
    fi
fi

echo "Installation script completed. Remember to configure butler-ci-cli as needed."