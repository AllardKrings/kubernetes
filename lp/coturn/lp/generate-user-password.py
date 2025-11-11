import hmac
import hashlib
import base64
import time

# Replace with your actual secret and realm
secret = b'heleenvanderpol'
realm = 'coturn-lp.allarddcs.nl'

# Step 1: Generate a timestamp-based username valid for ~24 hours
username = str(int(time.time()) + 3600 * 24)

# Step 2: Create password using HMAC-SHA1
key = hmac.new(secret, username.encode('utf-8'), hashlib.sha1)
password = base64.b64encode(key.digest()).decode('utf-8')

print("Username:", username)
print("Password:", password)
