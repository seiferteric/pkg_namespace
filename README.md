#Linux Package Namespacing

It can sometimes be difficult to know what binaries/commands are installed by a given package, especially if the binary names are completely different than the package name itself. This can be a stumbling block for newer linux/unix users I feel since the discoverability of commands via tab complete, or even just looking in the *bin directories is lacking any context of where each command comes from.

This script attempts to solve this by creating a new bin directory that you can add to your PATH. In the bin directory is symlinks to every command installed via a package on your system, but prefixed with the package in this format: 

    pkg_name#command

So for example, imagemagick convert command in bash tab complete looks like this:

    $ imagemagick-6.q16#convert

In this case that actual package name is `imagemagick-6.q16`

## Install

git clone xxx

## Usage

    cd pkg_namespace
    ./build_namespaces.sh
    export PATH=$PATH:$PWD/bin


## Limitations

 - Currently only works on debian based systems (only tested in Ubuntu 18.04)
 - You must re-run the script to rebuild the bin directory when you install new packages