#
# require rancher/rke provider:
# https://www.terraform.io/docs/configuration/provider-requirements.html
#
terraform {
  required_providers {
    rke = {
      source  = "rancher/rke"
      version = "1.1.0"
    }
  }
}

provider "rke" {
    log_file = "rke_debug.log"
}

resource "rke_cluster" "LocalTestCluster" {
  nodes {
    address = "127.0.0.1"
    user    = "k8s"
    role    = ["controlplane", "worker", "etcd"]
  }
}

###############################################################################
# If you need kubeconfig.yml for using kubectl, please uncomment follows.
###############################################################################
resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.LocalTestCluster.kube_config_yaml
}

