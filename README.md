# Linux Package Namespacing

It can sometimes be difficult to know what binaries/commands are installed by a given package, especially if the binary names are completely different than the package name itself. This can be a stumbling block for newer linux/unix users I feel since the discoverability of commands via tab complete, or even just looking in the *bin directories is lacking any context of where each command comes from. There are of course ways to figure out what commands are installed, but in order to do that you have to know those commands... Which you might imagine is a bit of a problem.

This script attempts to solve this by creating a new bin directory that you can add to your PATH. In the bin directory is symlinks to every command installed via a package on your system, but prefixed with the package in this format: 

    pkg_name#command

So for example, imagemagick convert command in bash tab complete looks like this:

    $ imagemagick-6.q16#convert

In this case that actual package name is `imagemagick-6.q16`

Another example with systemd showing via tab completion all the commands it installs. Even though many systemd commands start with `systemd-`, as you can see many of them don't.

```
$ systemd#
systemd#bootctl                         systemd#systemd-ask-password            systemd#systemd-path
systemd#busctl                          systemd#systemd-cat                     systemd#systemd-resolve
systemd#hostnamectl                     systemd#systemd-cgls                    systemd#systemd-run
systemd#journalctl                      systemd#systemd-cgtop                   systemd#systemd-socket-activate
systemd#kernel-install                  systemd#systemd-delta                   systemd#systemd-stdio-bridge
systemd#localectl                       systemd#systemd-detect-virt             systemd#systemd-sysusers
systemd#loginctl                        systemd#systemd-escape                  systemd#systemd-tmpfiles
systemd#networkctl                      systemd#systemd-inhibit                 systemd#systemd-tty-ask-password-agent
systemd#systemctl                       systemd#systemd-machine-id-setup        systemd#systemd-umount
systemd#systemd                         systemd#systemd-mount                   systemd#timedatectl
systemd#systemd-analyze                 systemd#systemd-notify                  
```

## Install

git clone https://github.com/seiferteric/pkg_namespace.git

## Usage

    cd pkg_namespace
    ./build_namespaces.sh
    export PATH=$PATH:$PWD/bin


## Limitations

 - Currently only works on debian based systems (only tested in Ubuntu 18.04)
 - You must re-run the script to rebuild the bin directory when you install new packages
