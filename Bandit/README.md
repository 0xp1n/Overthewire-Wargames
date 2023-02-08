# Automatic retrieve the flags from [Bandit wargame](https://overthewire.org/wargames/bandit)

This script apply a payload in bash for each level to fetch automatically the flags and dump it into a .txt file. We take advantage of the command `expect` to fill in automatically the password via ssh connection from the previous level. Take into account that this command **maybe is not available in your system**.

In case is not, here we left some of the installation commands:

```bash
# Just check if the command exists
command -v expect # /usr/bin/expect
#or
which expect # /usr/bin/expect

##### OS distributions ######

# Debian
sudo apt install expect

# Fedora
sudo dnf install expect

# ArchLinux
sudo pacman -Sy expect
```

Further information to install with `snapd` [Snapcraft](https://snapcraft.io/expect)

## Usage

To start the process make sure you have execution permissions for the script `pwnbandit.sh` before run it:

```bash
chmod  u+x pwnbandit.sh
./pwnbandit.sh
#or
bash pwnbandit.sh
```
