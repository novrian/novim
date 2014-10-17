#!/bin/bash
#
# Custom Build Script
echo "Building Vim Scripts"
echo "..."
if [ -f bundle/snipmate.vim/after/plugin/snipMate.vim ];
then
	rm bundle/snipmate.vim/after/plugin/snipMate.vim
	echo "snipMate.vim Deleted!"
fi
echo "Finish!"
