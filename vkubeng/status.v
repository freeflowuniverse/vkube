module crystalkube

struct Status {
	api_version string [json: apiVersion]
	kind string
	status string
	message string
	reason string
}

