
module "k8s_cluster" {
    source = "../modules/k8s_cluster"

    rancher_rke_debug   = false
    k8s_nodes           = [
        {
            address = "10.75.13.1"
            name    = "prdnode01"
        },
        {
            address = "10.75.13.2"
            name    = "prdnode02"
        },
        {
            address = "10.75.13.3"
            name    = "prdnode03"
        },
        {
            address = "10.75.13.4"
            name    = "prdnode04"
        },
        {
            address = "10.75.13.5"
            name    = "prdnode05"
        }

    ]
}

