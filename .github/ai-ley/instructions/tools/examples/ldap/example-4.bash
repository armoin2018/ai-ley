# OpenLDAP client tools (Debian/Ubuntu)
sudo apt-get install ldap-utils

# Basic connectivity test
ldapwhoami -x -H ldap://ldap.example.com -D "cn=admin,dc=example,dc=com" -w 'password'

# Search examples (anonymous or bound)
ldapsearch -x -H ldap://ldap.example.com -b "dc=example,dc=com" "(objectClass=person)" cn mail

# Add entries from LDIF
ldapadd -H ldap://ldap.example.com -D "cn=admin,dc=example,dc=com" -w 'password' -f users.ldif

# Modify entries
ldapmodify -H ldap://ldap.example.com -D "cn=admin,dc=example,dc=com" -w 'password' <<'EOF'
dn: uid=jdoe,ou=People,dc=example,dc=com
changetype: modify
replace: mail
mail: jdoe@example.com
EOF

# Delete entries
ldapdelete -H ldap://ldap.example.com -D "cn=admin,dc=example,dc=com" -w 'password' "uid=jdoe,ou=People,dc=example,dc=com"