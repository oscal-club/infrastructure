# Terraform

## Prerequisites and Installation

This project uses [`asdf`](https://asdf-vm.com/) to manage the installation of `terraform` and other language runtimes.

To install Terraform, the following commmand is run on the developer workstation and/or services for continuous integration and/or continuous deployment.

```sh
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
echo 'source "$HOME/.asdf/asdf.sh"' | tee -a "$HOME/.bashrc"
echo 'source "$HOME/.asdf/completions/asdf.bash"' | tee -a "$HOME/.bashrc"
source "$HOME/.bashrc"
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf install terraform latest
asdf global terraform latest
```

### Terraform Components

#### DNS Configuration

##### Importing Existing DNS Configuration into Terraform State

To pull in existing record definitions from the DNS provider into state of the Terraform and its dependent modules, run a command like so.

```sh
terraform import 'module.dns_website_hosting.gandi_livedns_record.records["A:@"]' "domain.tld/@/A"
```