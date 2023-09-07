#!/bin/bash

cd /tmp
apt update
apt upgrade -y
apt install -y vsftpd
sed -i {'s/listen=NO/listen=YES/;s/listen_ipv6=YES/listen_ipv6=NO/;s/#write_enable=YES/write_enable=YES/;s/#chroot_local_user=YES/chroot_local_user=YES/;s/#chroot_list_enable=YES/chroot_list_enable=YES/;s/#chroot_list_file=\/etc\/vsftpd.chroot_list/chroot_list_file=\/etc\/vsftpd\/vsftpd.chroot_list/;s/ssl_enable=NO/ssl_enable=YES/;s/#xferlog_file=\/var\/log\/vsftpd.log/xferlog_file=\/var\/log\/vsftpd.log/;s/#chown_uploads=YES/chown_uploads=YES/;s/#local_umask=022/local_umask=022/'} /etc/vsftpd.conf
sed -i 's/ExecStart=\/usr\/sbin\/vsftpd \/etc\/vsftpd.conf/ExecStart=\/usr\/sbin\/vsftpd \/etc\/vsftpd\/vsftpd.conf/' /lib/systemd/system/vsftpd.service
echo "allow_writeable_chroot=YES
dirlist_enable=YES" >> /etc/vsftpd.conf
mkdir /etc/vsftpd
mv /etc/vsftpd.conf /etc/vsftpd
echo $username > /etc/vsftpd/vsftpd.chroot_list
systemctl daemon-reload
systemctl restart vsftpd
