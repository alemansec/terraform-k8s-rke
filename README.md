
# About

Playing with terraform to provision a kubernetes cluster on baremetal


# Setup

## terraform setup

I'll be adding those steps to my ansible playbooks (private repository), but here are the manual steps used to install terraform on the 'client'/managing machine.

Later on, a single machine will run terraform commands, so deployments states are kept at a unique place, preventing conflicts.


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

### terraform provider for Rancher Kubernetes Engine


https://github.com/rancher/terraform-provider-rke

For terraform 0.13 or above users, manual installation is not required anymore. Provider will be downloaded by terraform init from terraform rke registry.


# local run

Local deployment to validate the whole thing without deploying on the actual target machines.

```
  # 'k8s' user account will be used to provision k8s cluster on target machines:
  # i use 'localhost' during this test, will (obviously) later use multiple VM(s).
  sudo adduser --ingroup docker k8s
  ssh-copy-id k8s@localhost

  cd terraform/dev/ # dev || staging || production

  vi main.tf

  terraform init
  terraform plan
  terraform apply

  terraform destroy
```


# TODO

- [ ] deploy an entire cluster on suitable virtual machines

- [ ] add k8s dashboard deployment to terraform files

- [ ] deploy a test webserver service

- [ ] use remote state ( https://www.terraform.io/docs/state/remote.html )

- [ ] use state locking ( https://www.terraform.io/docs/state/locking.html )


