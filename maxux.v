import crystalkube

rootca := "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJkekNDQVIyZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWpNU0V3SHdZRFZRUUREQmhyTTNNdGMyVnkKZG1WeUxXTmhRREUyTWprM016YzNPRFl3SGhjTk1qRXdPREl6TVRZMU5qSTJXaGNOTXpFd09ESXhNVFkxTmpJMgpXakFqTVNFd0h3WURWUVFEREJock0zTXRjMlZ5ZG1WeUxXTmhRREUyTWprM016YzNPRFl3V1RBVEJnY3Foa2pPClBRSUJCZ2dxaGtqT1BRTUJCd05DQUFTamhKOU9iR0w0NXBucUR4MjBFZkUvOEg4d3JmamxBOVNGMVpiS1NzWFgKc09HVVBnUGIwZnRmUHVXVjlaMERERzhLOFBwR3ZCNTBEV1duWm1lUkVPVHVvMEl3UURBT0JnTlZIUThCQWY4RQpCQU1DQXFRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVVNCT2dqV0poTjZYUSsvS213bjZqCnRFL1AvSnd3Q2dZSUtvWkl6ajBFQXdJRFNBQXdSUUlnVzBuNXBUVGZoRHJYdnZDNkt5Wkl0MCthR2RSdmdmd1MKYkNpL1E5Um5XTUlDSVFDQkVuY2p6V0l4VXFsTXRoZkkvVVhyZEZtekhQU3ExcGh3cmhhVnNnY1lndz09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
cert := "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJrRENDQVRlZ0F3SUJBZ0lJSkhqdVI2L1plWEF3Q2dZSUtvWkl6ajBFQXdJd0l6RWhNQjhHQTFVRUF3d1kKYXpOekxXTnNhV1Z1ZEMxallVQXhOakk1TnpNM056ZzJNQjRYRFRJeE1EZ3lNekUyTlRZeU5sb1hEVEl5TURneQpNekUyTlRZeU5sb3dNREVYTUJVR0ExVUVDaE1PYzNsemRHVnRPbTFoYzNSbGNuTXhGVEFUQmdOVkJBTVRESE41CmMzUmxiVHBoWkcxcGJqQlpNQk1HQnlxR1NNNDlBZ0VHQ0NxR1NNNDlBd0VIQTBJQUJQYmNzY2pmZkgzeHRMOWUKVGViMWNOczg5OFUvekl6WmU0ZG11N3l6TDNid0ZSTGJaS1plOTBwZUszRWJFeEJwV0lpaTlEdFdDZ2VnUk9VawpvZ0ZaY1R1alNEQkdNQTRHQTFVZER3RUIvd1FFQXdJRm9EQVRCZ05WSFNVRUREQUtCZ2dyQmdFRkJRY0RBakFmCkJnTlZIU01FR0RBV2dCVFZPczFyOUwzUzJSYk5vcU5RbXgyR3hiSnlnakFLQmdncWhrak9QUVFEQWdOSEFEQkUKQWlBUlcvdDdtaW1vekpVTFpJUHpwdjhsL1U5L05ldm9IUGJjbWMxQTFQNzhXd0lnRklULzRUOXNNSEJOWnpFUApMUXZhQUdsc3JLc3JubGJlNzN5RUtVay96WFE9Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0KLS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJkekNDQVIyZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWpNU0V3SHdZRFZRUUREQmhyTTNNdFkyeHAKWlc1MExXTmhRREUyTWprM016YzNPRFl3SGhjTk1qRXdPREl6TVRZMU5qSTJXaGNOTXpFd09ESXhNVFkxTmpJMgpXakFqTVNFd0h3WURWUVFEREJock0zTXRZMnhwWlc1MExXTmhRREUyTWprM016YzNPRFl3V1RBVEJnY3Foa2pPClBRSUJCZ2dxaGtqT1BRTUJCd05DQUFSeFFTVGphZG5IaTRUbnJNVHJ2RE9pR0lpbDdaWGZ0SG9iaE8yQ3hyQVYKRXFmS003dmNlSWpyMzhwMjJ3R1d0U1BJZlhWK2xjRlpjeEUwVlY1ZzB0cEFvMEl3UURBT0JnTlZIUThCQWY4RQpCQU1DQXFRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVTFUck5hL1M5MHRrV3phS2pVSnNkCmhzV3ljb0l3Q2dZSUtvWkl6ajBFQXdJRFNBQXdSUUloQUkzUEREWDJSdjA0bFc1cngrQTJROG1VZnNPckUyQzEKdzdRT0ZzeVM4bU9BQWlCeGxMWWJCK0lERCtNelJhRHFBeHZEeUU5aEt4TlBJaVVrQkJCaHVRdDl0UT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
key := "LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSUV4c1YxMVJrVE10RC82Z3FhYTRCcHVXM1k1UlFRYWtXdnVwVEMvMFJzQnhvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFOXR5eHlOOThmZkcwdjE1TjV2VncyenozeFQvTWpObDdoMmE3dkxNdmR2QVZFdHRrcGw3MwpTbDRyY1JzVEVHbFlpS0wwTzFZS0I2QkU1U1NpQVZseE93PT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQo="

mut k := crystalkube.kube_get()
k.authorize(rootca, cert, key)
k.api_info()
k.pods_gets()

x := crystalkube.template_redis("1.2.3")
println(x)
k.pod_create(x.encode())

