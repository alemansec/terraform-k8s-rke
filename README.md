
Provision a kubernetes cluster on baremetal

# terraform setup

```
  # (on 'client'/desktop machine) :
  # https://www.terraform.io/docs/cli/install/apt.html
  #
  # note, not yet available for bullseye ; use buster repos intead:
  # deb [arch=amd64] https://apt.releases.hashicorp.com buster main
  #
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

  sudo apt-get install terraform
```

# terraform provider for Rancher Kubernetes Engine


https://github.com/rancher/terraform-provider-rke

For terraform 0.13 or above users, manual installation is not required anymore. Provider will be downloaded by terraform init from terraform rke registry.


# minimal terraform cluster definition

```
# minimal.tf
# https://github.com/rancher/terraform-provider-rke/blob/master/examples/minimal/example.tf
#
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
  content  = rke_cluster.cluster.kube_config_yaml
}

```


# local test

```
  # 'k8s' user account will be used to provision k8s cluster on target machine:
  # i use 'localhost' during this test, will (obviously) later use multiple VM(s).
  sudo adduser --ingroup docker k8s
  ssh-copy-id k8s@localhost

  # run terraform
  cd terraform/ # where kubernetes-cluster-baremetal-minimal.tf resides

  terraform init
  terraform plan
  terraform apply

  terraform destroy
```



