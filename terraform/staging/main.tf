
module "k8s_cluster" {
    source = "../modules/k8s_cluster"

    rancher_rke_debug   = false
    k8s_nodes           = [
        {
            address = "10.42.1.1"
            name    = "stgnode01"
        },
        {
            address = "10.42.1.2"
            name    = "stgnode02"
        },
        {
            address = "10.42.1.3"
            name    = "stgnode03"
        },
        {
            address = "10.42.1.4"
            name    = "stgnode04"
        },
        {
            address = "10.42.1.5"
            name    = "stgnode05"
        }

    ]
}

