module crystalkube

import json

struct Kube_Redis {
	api_version string
	kind string
	metadata Kube_Redis_Metadata
	spec Kube_Redis_Spec
}

struct Kube_Redis_Metadata {
	name string
}

struct Kube_Redis_Spec {
	containers []Kube_Redis_Container
	volumes []Kube_Redis_Volume
}

struct Kube_Redis_Container {
mut:
	name string
	image string
	command []string
	env []Kube_Name_Value
	ports []Kube_Redis_Containers_Port
	resources Kube_Redis_Containers_Resource
	volume_mounts []Kube_Redis_Containers_VolumeMount
}

struct Kube_Name_Value {
	name string
	value string
}

struct Kube_Redis_Containers_Port {
	container_port int
}

struct Kube_Redis_Containers_Resource {
	limits Kube_Redis_Containers_Resources_Limit
}

struct Kube_Redis_Containers_Resources_Limit {
	cpu string
}

struct Kube_Redis_Containers_VolumeMount {
	mount_path string
	name string
}

struct Kube_Redis_Volume {
	name string
	empty_dir Kube_Redis_Volume_EmptyDir
mut:
	config_map Kube_Redis_Volume_ConfigMap
}

struct Kube_Redis_Volume_ConfigMap {
	name string
mut:
	items []Kube_Redis_Volume_ConfigMap_Item
}

struct Kube_Redis_Volume_ConfigMap_Item {
	key string
	path string
}

struct Kube_Redis_Volume_EmptyDir {

}

pub fn template_redis(version string) Kube_Redis {
	mut c := Kube_Redis_Container{
		name: "redis",
		image: "redis:$version",
		command: ["redis-server", "/redis-master/redis.conf"],
		resources: Kube_Redis_Containers_Resource{
			limits: Kube_Redis_Containers_Resources_Limit{
				cpu: "0.1",
			}
		}
	}

	c.env << Kube_Name_Value{name: "MASTER", value: "true"}
	c.ports << Kube_Redis_Containers_Port{container_port: 6379}
	c.volume_mounts << Kube_Redis_Containers_VolumeMount{mount_path: "/redis-master", name: "config"}

	mut cs := []Kube_Redis_Container{}
	cs << c

	mut v1 := Kube_Redis_Volume{
		name: "data",
		empty_dir: Kube_Redis_Volume_EmptyDir{}
	}

	mut v2 := Kube_Redis_Volume{
		name: "config",
		config_map: Kube_Redis_Volume_ConfigMap{
			name: "example-redis-config",
			items: []Kube_Redis_Volume_ConfigMap_Item{}
		}
	}

	v2.config_map.items << Kube_Redis_Volume_ConfigMap_Item{key: "redis-config", path: "redis.conf"}

	mut vs := []Kube_Redis_Volume{}
	vs << v1
	vs << v2

	return Kube_Redis{
		api_version: "v1",
		kind: "Pod",
		metadata: Kube_Redis_Metadata{
			name: "redis",
		},
		spec: Kube_Redis_Spec{
			containers: cs,
			volumes: vs,
		},
	}
}

pub fn (k Kube_Redis) encode() string {
	return json.encode(k)
}
