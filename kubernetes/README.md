*Enable etcd basic authentication*

1. create root account 
curl -X PUT -d "{\"user\":\"root\",\"password\":\"PASSWORD\",\"roles\":[\"root\"]}" http://localhost:4001/v2/auth/users/root

2. enable auth 
curl -X PUT http://localhost:4001/v2/auth/enable

3. revoke guest's permission
AUTHSTR=$(echo -n "root:PASSWORD" | base64)
curl -H "Authorization: Basic $AUTHSTR" -X PUT -d "{\"role\":\"guest\",\"revoke\":{\"kv\":{\"read\":[\" * \"],\"write\":[\" * \"]}}}" http://localhost:4001/v2/auth/roles/guest
