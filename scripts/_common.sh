#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

signald_data="/var/lib/signald"
signald_exe="/usr/bin/signald"
signald_user="signald"

enable_relaybot=true

#=================================================
# PERSONAL HELPERS
#=================================================

_install_rustup() {
    export PATH="$PATH:$install_dir/.cargo/bin:$install_dir/.local/bin:/usr/local/sbin"

    if [ -e "$install_dir/.rustup" ]; then
        ynh_exec_as "$app" env "PATH=$PATH" rustup update
    else
        ynh_exec_as "$app" bash -c 'curl -sSf -L https://static.rust-lang.org/rustup.sh | sh -s -- -y --default-toolchain=stable --profile=minimal'
    fi
}

_mautrix_signal_build_venv() {
    python3 -m venv "$install_dir/venv"
    "$install_dir/venv/bin/pip3" install --upgrade pip setuptools wheel
    "$install_dir/venv/bin/pip3" install --upgrade \
        "$install_dir/src/mautrix-signal.tar.gz[metrics,e2be,formattednumbers,qrlink,stickers]"
}

get_synapse_db_name() {
	# Parameters: synapse instance identifier
	# Returns: database name
	ynh_app_setting_get --app="$1" --key=db_name
}


#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
