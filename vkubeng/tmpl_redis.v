module crystalkube

pub fn template_redis(version string) Pod {
	mut p := pod_new()
	p.metadata("redis")

	mut c := pod_container_new()
	c.name("redis")
	c.image("redis:$version")
	c.command(["redis-server", "/redis-master/redis.conf"])
	c.resources.limits.cpu("0.1")
	c.envset("MASTER", "true")

	c.ports << pod_container_port(6379)
	c.volume_mounts << pod_container_volume_mount("/redis-master", "config")

	p.container_add(c)

	mut v1 := pod_volume_emptydir_new("data")

	mut v2 := pod_volume_configmap_new("config")
	v2.config_map = Pod_Volume_ConfigMap{
		name: "example-redis-config",
		items: []Pod_Volume_ConfigMap_Item{}
	}

	v2.config_map.items << Pod_Volume_ConfigMap_Item{key: "redis-config", path: "redis.conf"}

	p.volume_add(v1)
	p.volume_add(v2)

	return p
}

