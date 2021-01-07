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
    debug = var.rancher_rke_debug
    log_file = "rke_debug.log"
}

resource "rke_cluster" "LocalPocCluster" {
  dynamic nodes {
    for_each = var.k8s_nodes
    content {
      address = nodes.value.address
      node_name = nodes.value.name
      user    = var.host_provisionning_user
      role    = ["controlplane", "worker", "etcd"]
    }
  }

  #########################################################
  # Network(CNI) - supported: flannel/calico/canal/weave
  #########################################################
  network {
    plugin = "flannel"
  }

  ingress {
    provider = "nginx"
    options = {
      proxy-buffer-size = "16k"
      http2 = "true"
    }
  #  extra_args = {
  #    default-ssl-certificate = "ingress-nginx/wildcard-ingress"
  #  }
  }

}

###############################################################################
# If you need kubeconfig.yml for using kubectl, please uncomment follows.
###############################################################################
resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.LocalPocCluster.kube_config_yaml
}


