module vkube

//kubectl get pod redis -o jsonpath="{.spec.containers[0]}"

example_return := """
{
  "command": [
    "redis-server",
    "/redis-master/redis.conf"
  ],
  "env": [
    {
      "name": "MASTER",
      "value": "true"
    }
  ],
  "image": "redis:6.2.5",
  "imagePullPolicy": "IfNotPresent",
  "name": "redis",
  "ports": [
    {
      "containerPort": 6379,
      "protocol": "TCP"
    }
  ],
  "resources": {
    "limits": {
      "cpu": "100m"
    },
    "requests": {
      "cpu": "100m"
    }
  },
  "terminationMessagePath": "/dev/termination-log",
  "terminationMessagePolicy": "File",
  "volumeMounts": [
    {
      "mountPath": "/redis-master",
      "name": "config"
    },
    {
      "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
      "name": "kube-api-access-rhvc4",
      "readOnly": true
    }
  ]
}
"""