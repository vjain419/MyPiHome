#Transmission Setup
echo "=== [Info] Updating Rasbian"
echo "sudo apt-get update"
echo "sudo apt-get upgrade"
echo "=== [Info] Update Complete ..."
sudo apt-get install transmission-daemon

read -p "Do you Want to Create Seperate Directory for in-progress and completed? [y/n] " answer

if [ $answer = "y" ]
then
  echo "yes"
  echo "Below are current Media Storage. Please Select One Where you want to store the downloaded content"
  ls /media/pi
  read -p "Storage Path Name : " path
  echo "sudo mkdir -p /media/pi/"$path"/torrent_in_progress"
  echo "sudo mkdir -p /media/pi/"$path"/torrent_complete"
  sudo sed 's|"incomplete-dir": "/var/lib/transmission-daemon/Downloads"|"incomplete-dir": "/media/pi/$path/torrent_in_progress"|' /etc/transmission-daemon/settings.json
  sudo sed 's|"incomplete-dir-enabled": false|"incomplete-dir-enabled": true|' /etc/transmission-daemon/settings.json
  sudo sed 's|"download-dir": "/var/lib/transmission-daemon/downloads"|"download-dir": "/media/pi/$path/torrent_complete"|' /etc/transmission-daemon/settings.json
  read -p "Username : " username
  read -p "Password : " password
  sudo sed 's|"rpc-password": ".*"|"rpc-password": "$password"|' /etc/transmission-daemon/settings.json
  sudo sed 's|"rpc-username": "transmission"|"rpc-username": "$username"|' /etc/transmission-daemon/settings.json
  sudo sed 's|"rpc-whitelist": ".*"|"rpc-whitelist": "192.168.*.*"|' /etc/transmission-daemon/settings.json

else 
  echo "no"
fi
