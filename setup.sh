echo "******************************************************************************"
echo "Prepare SO." `date`
echo "******************************************************************************"

echo "SELINUX Configuration: "
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
setenforce 0 && getenforce ## permissive

echo "Firewall Configuration:"
systemctl stop firewalld && systemctl status firewalld && systemctl disable firewalld

echo "NTP Configuration:"
sudo timedatectl set-timezone America/Sao_Paulo
sed -i 's/^server/#server/' /etc/chrony.conf

echo "server a.st1.ntp.br iburst" >> /etc/chrony.conf
echo "server b.st1.ntp.br iburst" >> /etc/chrony.conf
echo "server c.st1.ntp.br iburst" >> /etc/chrony.conf
echo "server d.st1.ntp.br iburst" >> /etc/chrony.conf

systemctl start chronyd && systemctl enable chronyd && systemctl status chronyd && chronyc sources

echo "==================================================================="
echo Install Splunk
echo "==================================================================="

sudo wget -qO splunk-8.0.5-a1a6394cc5ae-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.5&product=splunk&filename=splunk-8.0.5-a1a6394cc5ae-Linux-x86_64.tgz&wget=true'
sudo tar xzf splunk-8.0.5-a1a6394cc5ae-Linux-x86_64.tgz -C /opt/
groupadd -g 1001 splunk
/usr/sbin/useradd -u 1001 -g splunk splunk
sudo cat << EOF > /opt/splunk/etc/system/local/user-seed.conf
[user_info]
USERNAME=admin
PASSWORD=teste123
EOF
sudo chown -R splunk:splunk /opt/splunk
sudo -u splunk /opt/splunk/bin/splunk start --accept-license --answer-yes
sudo /opt/splunk/bin/splunk enable boot-start -user splunk
sudo -u splunk /opt/splunk/bin/splunk stop
sudo systemctl enable splunk && systemctl start splunk && systemctl status splunk


