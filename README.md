## My Vim config

Clone with:

    git clone git@github.com:moshen/vimconfig.git .vim

or

    git clone https://github.com/moshen/vimconfig.git .vim

Run `setup.sh`!

`setup.sh` usage:

    ./setup.sh [-r] [branch]

    -r     - Remote mode, grabs the entire vimconfig from git
    branch - Detaults to master, vimconfig branch to checkout

---------------------------------------

Here's a handy script for copy-paste:

    cd $HOME &&
    git clone https://github.com/moshen/vimconfig.git .vim &&
    cd .vim &&
    ./setup.sh

OR... Installing directly from GitHub:

    (echo set -- -r; curl "https://raw.github.com/moshen/vimconfig/master/setup.sh") | bash

