# vkubeng

Tested with k3s only for now.

# Authentication

Get credentials with `credentials.sh` script. This script require `k3s.yaml` file as first argument.

This file is stored in `/etc/rancher/k3s/k3s.yaml` in k3os image.

Example:
```
$ scp rancher@10.241.0.67:/etc/rancher/k3s/k3s.yaml /tmp/

$ bash credentials.sh /tmp/k3s.yaml 
rootca := "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0..."
cert := "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tC..."
key := "LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS..."
```

You can use theses credentials directly into V code then.
