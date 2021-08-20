
struct KubeRedis{
	apiVersion string
	kind Kind
	metadata Metadata

}

enum Kind{
	pod
}

struct Metadata{
	items []MetadataItem
}

struct MetadataItem{
	key string
	val string
}

data='
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "redis"
  },
  "spec": {
    "containers": [
      {
        "name": "redis",
        "image": "redis:5.0.4",
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
        "ports": [
          {
            "containerPort": 6379
          }
        ],
        "resources": {
          "limits": {
            "cpu": "0.1"
          }
        },
        "volumeMounts": [
          {
            "mountPath": "/redis-master-data",
            "name": "data"
          },
          {
            "mountPath": "/redis-master",
            "name": "config"
          }
        ]
      }
    ],
    "volumes": [
      {
        "name": "data",
        "emptyDir": {}
      },
      {
        "name": "config",
        "configMap": {
          "name": "example-redis-config",
          "items": [
            {
              "key": "redis-config",
              "path": "redis.conf"
            }
          ]
        }
      }
    ]
  }
}
'