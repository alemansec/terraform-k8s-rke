
module "k8s_cluster" {
    source = "../modules/k8s_cluster"

    rancher_rke_debug   = true
    k8s_nodes           = [
        {
            address = "127.0.0.1"
            name    = "devtestnode"
        }
    ]
}

