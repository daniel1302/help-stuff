<?php
/**
 * This is a script that add allow rule in /etc/squid/squid.conf
 *
 * To support auto restart squid you need add follow line to /etc/sudoers
 *
 *        http ALL=(ALL) NOPASSWD: /sbin/systemctl restart squid
 * 
 */


error_reporting(E_ALL);
if (!isset($_SERVER['REMOTE_ADDR'])) {
	die('Cannot get your IP');	
}


$file = '/etc/squid/squid.conf';
$ip = $_SERVER['REMOTE_ADDR'];
$originalContent = file_get_contents($file);
$aclLabel = str_replace('.', '_', $ip);


if (strpos($originalContent, $ip) !== false) {
	die("DONE");
}


$newContent = str_replace('#NEW_ACL', sprintf("acl %s src %s/32\n#NEW_ACL", $aclLabel, $ip), $originalContent);
$newContent = str_replace('#NEW_ACCESS', sprintf("http_access allow %s\n#NEW_ACCESS", $aclLabel), $newContent);

file_put_contents($file, $newContent);
passthru("sudo /sbin/systemctl restart squid");
echo "Done";
