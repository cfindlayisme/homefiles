# Yubikey setup for GPG/SSH/etc
This is my setup for my Yubikeys on my machines. They hold my signing and encryption keys, which works for SSH, git commit signing, etc.

Most recently done on Pop! OS in August 2020

## Software installs
Most of the software is already installed by standard in Ubuntu/Pop! OS desktop installs, so this is just the other required software.

    sudo apt install scdaemon

After the install re-insert the Yubikey

## ~/.bashrc config for SSH
The below is added to ~/.bashrc so gpg-agent is used for SSH authentication. Already included in the .bashrc in this repository.

    # Set SSH to use gpg-agent
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
    fi

    # Start the gpg-agent if not already running
    if ! pgrep -x -u "$USER" gpg-agent >/dev/null 2>&1; then
    gpg-connect-agent /bye >/dev/null 2>&1
    fi

## Git signing config
This step is so commits are signed with the GPG key on the Yubikey.

Make sure below is inside ~/.gitconfig

    [user]
        signingkey = <key>
    [commit]
        gpgSign = true
