
#
# user account on remote machines we'll use to provision our cluster(s) :
# this user must be a member of 'docker' group
#
variable "host_provisionning_user" {
    type = string
    default = "k8s"
}

#
# enable rancher/rke debug
#
variable "rancher_rke_debug" {
    type = bool
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
    default = [

#        {
#            address = "10.75.13.1"
#            name    = "node01"
#        },
#        {
#            address = "10.75.13.2"
#            name    = "node02"
#        },
#        {
#            address = "10.75.13.3"
#            name    = "node03"
#        },
        {
            address = "127.0.0.1"
            name    = "localnode"
        }

    ]
}

