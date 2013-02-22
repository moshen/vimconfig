## My Vim config

Clone with:

    git clone git@github.com:moshen/vimconfig.git .vim

or

    git clone https://github.com/moshen/vimconfig.git .vim

Run `setup.sh`!

`setup.sh` usage:

    ./setup.sh [-r|-u|-h] [branch]

    -r      Remote setup, grabs your Vim config from GitHub
    -u      Update Vim config from GitHub and update all Bundles
    -h      Print this help
    branch  The branch name to checkout after setup.
            Defaults to 'master'. Only works with -r or no options

---------------------------------------

Here's a handy script for copy-paste:

    cd $HOME &&
    git clone https://github.com/moshen/vimconfig.git .vim &&
    cd .vim &&
    ./setup.sh

OR... Installing directly from GitHub:

    (echo set -- -r; curl "https://raw.github.com/moshen/vimconfig/master/setup.sh") | bash

