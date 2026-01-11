# Download Oracle Instant Client
# For Ubuntu/Debian
wget https://download.oracle.com/otn_software/linux/instantclient/oracle-instantclient-basic.deb
sudo dpkg -i oracle-instantclient-basic.deb

# Python driver
pip install cx_Oracle

# Alternative Python driver
pip install oracledb