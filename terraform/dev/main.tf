
module "k8s_cluster" {
    source = "../modules/k8s_cluster"

    rancher_rke_debug   = true
}

