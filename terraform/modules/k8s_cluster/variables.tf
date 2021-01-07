
#
# user account on remote machines we'll use to provision our cluster(s) :
# this user must be a member of 'docker' group
#
variable "host_provisionning_user" {
    type = string
    description = "the username passed to ssh when provisionning the cluster"
    default = "k8s"
}

#
# enable rancher/rke debug
#
variable "rancher_rke_debug" {
    type = bool
    description = "wether to enable RKE debug or not"
    default = false
}

#
# where to provision our k8s cluster:
#
variable "k8s_nodes" {
    type = list(object({
        address = string
        name    = string
    }))
    description = "target hosts' IP addresses ; cluster nodes will be provisionned here"
    default = [

        {
            address = "10.75.13.1"
            name    = "node01"
        },
        {
            address = "10.75.13.2"
            name    = "node02"
        },
        {
            address = "10.75.13.3"
            name    = "node03"
        },
        {
            address = "10.75.13.4"
            name    = "node04"
        },
        {
            address = "10.75.13.5"
            name    = "node05"
        }

    ]
}

