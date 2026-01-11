# CVSROOT/config file examples
SystemAuth=no                         # Disable system authentication
TopLevelAdmin=yes                      # Allow admin commands
LockDir=/var/lock/cvs                 # Lock directory
LogHistory=TOFEWGCMAR                 # History logging options
RereadLogAfterVerify=always           # Log message handling

# CVSROOT/modules file examples
project-a   project/projecta           # Simple module alias
project-b   -a project/projectb        # Module alias with -a flag
all-projects &project-a &project-b     # Meta-module combining others

# CVSROOT/passwd file format (pserver)
username:encrypted_password:system_user
anonymous::anonymous                   # Anonymous access
developer:$1$xyz$abc123:cvs           # Encrypted password