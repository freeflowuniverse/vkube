module crystalkube
import encoding.base64

struct Kube {
mut:
	debug bool

	host string
	port int

	rootca string  // certificate-authority-data
	cert string    // client-certificate-data
	key string     // client-key-data
}

// struct api responses


// object manager
pub fn kube_get() Kube {
	return Kube{debug: true}
}

// private functions
fn (k Kube) request(url string) {
	println("fetching $url")
}

// public functions

// rootca, cert and key should be base64 encoded
// this is /etc/rancher/k3s/k3s.yaml in k3os
pub fn (mut k Kube) authorize(rootca string, cert string, key string) {
	k.rootca = base64.decode(rootca).bytestr()
	k.cert = base64.decode(cert).bytestr()
	k.key = base64.decode(key).bytestr()

	if k.debug {
		println("== Root CA Certificate ==")
		println(k.rootca)

		println("== User Certificate ==")
		println(k.cert)

		println("== User Private Key ==")
		println(k.key)
	}
}

pub fn (k Kube) api_info() {
	println("COUCOU")
	k.request("/api")
}

pub fn (k Kube) pods_gets() {
	println("fetching pods")
	k.request("/api/v1/namespaces/default/pods")
}

pub fn (k Kube) pod_get() {

}

pub fn (k Kube) pod_create(object string) {
	println(object)
}
