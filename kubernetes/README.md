*Enable etcd basic authentication*

curl -X PUT -d "{\"user\":\"root\",\"password\":\"PASSWORD\",\"roles\":[\"root\"]}" http://localhost:4001/v2/auth/users/root
curl -X PUT http://localhost:4001/v2/auth/enable
AUTHSTR=$(echo -n "root:PASSWORD" | base64)
curl -H "Authorization: Basic $AUTHSTR" -X PUT -d "{\"role\":\"guest\",\"revoke\":{\"kv\":{\"read\":[\" * \"],\"write\":[\" * \"]}}}" http://localhost:4001/v2/auth/roles/guest
