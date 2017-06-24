#!/bin/bash

command -v code-formatter >/dev/null 2>&1 && { 
    echo "CodeFormatter is already installed."
    echo "If you wish to reinstall it (with the latest version), please remove '/usr/bin/code-formatter' executable."
    exit 0
}

if [ "$(id -u)" != "0" ]; then
    echo "Must be run as root. Exiting."
    exit 1
fi

#prerequisits
command -v git >/dev/null 2>&1 || {
    echo "No git found. Exiting."
    exit 1
}
command -v mono >/dev/null 2>&1 || {
    echo "No mono installation found. Exiting."
    exit 1
}

cd /tmp
echo -n "Cloning dotnet/codeformatter in /tmp... "
git clone https://github.com/dotnet/codeformatter >/dev/null 2>&1

if (( $? != 0 )); then
    echo "FAILED"
    echo "Exiting."
    exit 1
else
    echo "DONE"
fi

cd codeformatter

command -v nuget >/dev/null 2>&1 || {
    echo -n "Downloading nuget.exe... "
    curl -O https://dist.nuget.org/win-x86-commandline/latest/nuget.exe >/dev/null 2>&1
    echo "DONE"
}

bash init-tools.sh

cd src
echo -n "Restoring packages... "

if [ -f "../nuget.exe" ]; then
    mono ../nuget.exe restore >/dev/null
else
    nuget restore >/dev/null
fi

echo "DONE"

echo -n "Building solution... "
xbuild >/dev/null
echo "DONE"

cd ../bin/CodeFormatter/Debug
mkdir -p /opt/code-formatter
echo -n "Copying build arifacts to /opt/code-formatter... "
cp -r * /opt/code-formatter
echo "DONE"

echo -n "Creating executable 'code-formatter' in /usr/bin... "
echo -e "#!/bin/bash\nmono /opt/code-formatter/CodeFormatter.exe \"\$@\"" > /usr/bin/code-formatter
chmod +x /usr/bin/code-formatter
echo "DONE"

echo -n "Cleaning up... "
cd /tmp
rm -rf codeformatter
echo "DONE"

echo ""
echo "Installed CodeFormatter successfully!"
