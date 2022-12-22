#!/bin/sh

# Installation directory. By default it's /usr/bin
install_dir="${1:-/usr/bin}"
# The directory containing source files.
source_dir="$(pwd)/$(dirname $0)/src"

# Make the scripts executable for everyone and writable for the owner
chmod 755 "$source_dir"/*

echo -n "Copying into '$install_dir'... "
cp -p "$source_dir"/* "$install_dir" # 2>/dev/null
if [ $? = 0 ]
then
	echo "done."

	echo "Installation done. You might want to enable ALS by running the following command:"
	echo '    # Replace .bashrc with your shell file'
	echo '    echo "source \"\$HOME/.local/share/als/output.sh\"" >> ~/.bashrc'
	echo '    aa !'
	echo ''
else
	echo "error."
	echo "Couldn't copy ALS files. Try again."
	echo "This might be a permission error. Try running this script with root permissions."
fi
