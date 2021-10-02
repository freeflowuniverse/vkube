module crystalkube

[heap]
pub struct Kube {
pub mut:
	state KubeState
}

enum KubeState {
	ok
	error
}

fn kube_load() ?Kube {
	mut kube := Kube{}
	// kube.redis = redisclient.connect('127.0.0.1:6379') or { redisclient.Redis{} }
	return kube
}

// to create singleton
const kubeobj = kube_load() or {
	println('Cannot load configuraton for kubernetes tools.\n$err')
	println('===ERROR===')
	exit(1)
}

pub fn get() Kube {
	return crystalkube.kubeobj
}
