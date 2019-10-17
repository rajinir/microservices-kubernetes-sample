#update and install Pre-reqs
echo "Install Prereqs"
sudo apt-get update
sudo apt-get install ntp
sudo apt-get install -y apt-transport-https
sudo apt-get install -y firefox
sudo apt-get install -y xdg-utils
sudo apt-get install -y dbus-x11

echo "Install docker"
sudo apt-get install -y docker.io

echo "Installing virtualization - Virtualbox"
sudo apt-get install -y virtualbox virtualbox-ext-pack
