#
# Sets up J's favorite environment
#
# These are perfectly safe and reversible
#

export PATH=/jb/usr/bin:/jb/bin:/jb/sbin:/jb/usr/sbin:/jb/usr/local/bin:


echo Enabling SCP
mv /jb/usr/bin/scp /usr/bin/scp

echo Setting up ZSH Support files
mkdir -p /usr/local/lib/zsh/5.0.8/zsh
mv /jb/usr/local/lib/zsh/5.0.8/zsh/* /usr/local/lib/zsh/5.0.8/zsh 
mv /jb/bin/zsh /bin
mv /jb/etc/zshrc /etc

echo Setting up Terminfo Database
mkdir -p /usr/share/terminfo
mv /jb/usr/share/terminfo/* /usr/share/terminfo/

echo Moving J-tools to /usr/local/bin
mkdir -p /usr/local/bin
mv /jb/usr/local/bin/* /usr/local/bin


echo It\'s fine if you saw errors that some directories were not empty.
echo now feel free to run \'zsh\' instead of bash
