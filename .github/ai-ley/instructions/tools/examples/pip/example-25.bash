# Configure proxy
pip install --proxy http://proxy.server:port requests
pip config set global.proxy http://proxy.server:port

# Increase timeout
pip install --timeout 60 requests
pip config set global.timeout 60

# Use alternative index
pip install --index-url https://pypi.doubanio.com/simple/ requests