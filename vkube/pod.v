module vkube

import json

struct Pod {
	api_version string [json: apiVersion]
	kind string
mut:
	metadata Pod_Metadata
	spec Pod_Spec
}

struct Pod_Metadata {
mut:
	name string
}

type Pod_Volume = Pod_Volume_Type_EmptyDir | Pod_Volume_Type_ConfigMap

struct Pod_Spec {
mut:
	containers []Pod_Container
	volumes []Pod_Volume
}

struct Pod_Container {
mut:
	name string
	image string
	command []string
	env []Pod_Name_Value
	ports []Pod_Containers_Port
	resources Pod_Containers_Resource
	volume_mounts []Pod_Containers_VolumeMount [json: volumeMounts]
}

struct Pod_Name_Value {
	name string
mut:
	value string
}

struct Pod_Containers_Port {
	container_port int [json: containerPort]
}

struct Pod_Containers_Resource {
mut:
	limits Pod_Containers_Resources_Limit
}

struct Pod_Containers_Resources_Limit {
mut:
	cpu string
}

struct Pod_Containers_VolumeMount {
	mount_path string [json: mountPath]
	name string
}

struct Pod_Volume_Type_EmptyDir {
	name string
	empty_dir Pod_Volume_EmptyDir [json: emptyDir]
}

struct Pod_Volume_Type_ConfigMap {
	name string
mut:
	config_map Pod_Volume_ConfigMap [json: configMap]
}

struct Pod_Volume_ConfigMap {
	name string
mut:
	items []Pod_Volume_ConfigMap_Item
}

struct Pod_Volume_ConfigMap_Item {
	key string
	path string
}

struct Pod_Volume_EmptyDir {

}

pub fn pod_new() Pod {
	return Pod{
		api_version: "v1",
		kind: "Pod",
		spec: Pod_Spec{
			containers: []Pod_Container{},
			volumes: []Pod_Volume{},
		}
	}
}

//
// Pod
//
pub fn (mut p Pod) metadata(name string) {
	p.metadata.name = name
}

pub fn (mut p Pod) container_add(container Pod_Container) {
	p.spec.containers << container
}

pub fn (mut p Pod) volume_add(volume Pod_Volume) {
	p.spec.volumes << volume
}

//
// Pod Container
//
pub fn pod_container_new() Pod_Container {
	return Pod_Container{}
}

pub fn (mut p Pod_Container) name(name string) {
	p.name = name
}

pub fn (mut p Pod_Container) image(image string) {
	p.image = image
}

pub fn (mut p Pod_Container) command(command []string) {
	p.command = command
}

pub fn (mut p Pod_Container) envset(name string, value string) {
	// replace existing environment
	for mut env in p.env {
		if env.name == name {
			env.value = value
			return
		}
	}

	// insert new environment
	p.env << pod_container_env(name, value)
}

pub fn pod_container_env(name string, value string) Pod_Name_Value {
	return Pod_Name_Value{name: name, value: value}
}

pub fn pod_container_port(port int) Pod_Containers_Port {
	return Pod_Containers_Port{container_port: port}
}

pub fn (mut l Pod_Containers_Resources_Limit) cpu(value string) {
	l.cpu = value
}

pub fn pod_container_volume_mount(path string, name string) Pod_Containers_VolumeMount {
	return Pod_Containers_VolumeMount{mount_path: path, name: name}
}

pub fn pod_volume_emptydir_new(name string) Pod_Volume_Type_EmptyDir {
	return Pod_Volume_Type_EmptyDir{name: name}
}

pub fn pod_volume_configmap_new(name string) Pod_Volume_Type_ConfigMap {
	return Pod_Volume_Type_ConfigMap{name: name}
}

pub fn (p Pod) encode() string {
	return json.encode(p)
}
