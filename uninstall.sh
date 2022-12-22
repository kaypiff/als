#!/bin/sh

# Installation directory. By default it's /usr/bin
install_dir="${1:-/usr/bin}"
# The directory containing source files.
source_dir="$(pwd)/$(dirname $0)/src"
installed_files=$(for file in $(ls --color=never "$source_dir"); do echo "$install_dir/$file"; done)

echo -n "Removing from '$install_dir'... "
rm -f $installed_files 2>/dev/null
if [ $? = 0 ]
then
	echo "done."

	echo "Uninstallation done. You might want to disable ALS by running the following command:"
	echo '    # Replace .bashrc with your shell file'
	echo '    sed -i "/source \"\$HOME\/.local\/share\/als\/output.sh\"/d" ~/.bashrc'
	echo ''
else
	echo "error."
	echo "Couldn't remove ALS files. Try again."
	echo "This might be a permission error. Try running this script with root permissions."
fi
