module crystalkube

import net.http
import encoding.base64

struct Kube {
mut:
	debug bool

	host string
	port int
	endpoint string

	url string

	verify string  // certificate-authority-data
	cert string    // client-certificate-data
	key string     // client-key-data
}

struct APIVersions {
	kind string
	versions []string
}

// struct api responses


// object manager
pub fn kube_get(host string, port int, endpoint string) Kube {
	url := "https://$host:$port$endpoint"

	return Kube{
		debug: true,
		host: host,
		port: port,
		endpoint: endpoint,
		url: url
	}
}

// private functions
fn (k Kube) get(url string) ? string {
	println("fetching $url")

	vurl := "$k.url$url"

	r := http.fetch(
		validate: true
		url: vurl,
		verify: k.verify,
		cert: k.cert,
		cert_key: k.key,
		in_memory_verification: true
	) or {
		return error("could not connect to k8s: $err")
	}

	return r.text

}

fn (k Kube) post(url string, data string) ? string {
	println("posting to $url")

	vurl := "$k.url$url"

	r := http.fetch(
		validate: true
		url: vurl,
		verify: k.verify,
		cert: k.cert,
		cert_key: k.key,
		in_memory_verification: true
		method: .post,
		data: data,
		header: http.new_header(key: .content_type, value: 'application/json')

	) or {
		return error("could not post request to k8s: $err")
	}

	return r.text

}
// public functions

// rootca, cert and key should be base64 encoded
// this is /etc/rancher/k3s/k3s.yaml in k3os
pub fn (mut k Kube) authenticate(rootca string, cert string, key string) ? bool {
	println("[+] loading keys")
	k.verify = base64.decode(rootca).bytestr()
	k.cert = base64.decode(cert).bytestr()
	k.key = base64.decode(key).bytestr()

	/*
	k.verify = rootca
	k.cert = cert
	k.key = key
	*/

	if k.debug {
		println("== Root CA Certificate ==")
		println(k.verify)

		println("== User Certificate ==")
		println(k.cert)

		println("== User Private Key ==")
		println(k.key)
	}

	check := k.get("") or {
		return error("authentication failed")
	}

	// parse check response
	println(check)

	return true
}

pub fn (k Kube) api_info() {
	println("[+] fetching api information")
	// k.request("/api")?
}

pub fn (k Kube) pods_get(namespace string) ? string {
	println("fetching pods")

	r := k.get("/v1/namespaces/$namespace/pods")?
	return r
}

pub fn (k Kube) pod_get(namespace string, name string) {

}

pub fn (k Kube) pod_create(object Pod) ? string {
	j := object.encode()
	println(j)

	return k.post("/v1/namespaces/default/pods", j)
}
