#!/usr/bin/env bash

echo "# WARNING: This file was autogenerated on $(date). Do not edit."

# Search through all of the prefixes for the relevant paths and build
# searchpaths.
python=$(python --version | sed -E 's/^Python ([0-9]+\.[0-9]+)\.[0-9]+/\1/')
prefixes="$HOME/local:$HOME:$HOME/.local:$HOME/.cabal:$HOME/Library/Haskell:$HOME/.cargo:/usr/local:/opt/local:/opt/local/Library/Frameworks/Python.framework/Versions/$python:/usr"
path=/sbin:/usr/sbin
manpath=
infopath=
pkgconfigpath=

append_dir() {
	if test -d "$2"; then
		if test -z "${!1}"; then
			eval "$1=\$2"
		else
			eval "$1=\${!1}:\$2"
		fi
	fi
}

append_share_dir() {
	full="$2/$3"
	sfull="$2/share/$3"
	if test ! -L "$sfull" -o "$(readlink -f "$sfull")" != "$full"; then
		append_dir "$1" "$sfull"
	fi
	if test ! -L "$full" -o "$(readlink -f "$full")" != "$sfull"; then
		append_dir "$1" "$full"
	fi
}

for dir in ${prefixes//:/ }; do
	append_dir path "$dir/bin"
	append_dir path "$dir/libexec/gnubin"
	append_share_dir manpath "$dir" man
	append_share_dir infopath "$dir" info
	append_dir pkgconfigpath "$dir/lib/pkgconfig"
done

# Append /bin
append_dir path /bin


# Output paths:
cat <<EOF
export PATH="$path"
export MANPATH="$manpath"
export INFOPATH="$infopath"
export PKG_CONFIG_PATH="$pkgconfigpath"
EOF

# Output static variables
cat <<"EOF"
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export PAGER='less -R'
export CVS_RSH=ssh
export RSYNC_RSH=ssh
EOF

# Check for nvim
if which nvim >/dev/null; then
	echo 'export EDITOR=nvim'
else
	echo 'export EDITOR=vim'
fi


# Source .bashrc to load functions and aliases which are not exported.
cat <<EOF
. "$HOME/.bashrc"
EOF
