# Verbose client logging
LDAPTLS_REQCERT=demand LDAPDEBUG=1 ldapsearch -ZZ -H ldap://ldap.example.com -b dc=example,dc=com "(uid=jdoe)"

# Check server cert/chain
openssl s_client -connect ldap.example.com:636 -showcerts

# Index issues
sudo grep index /etc/ldap/slapd.d/cn=config/olcDatabase=*/olcDbIndex*.ldif