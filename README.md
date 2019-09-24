## How to use?

Copy **terraform.tfvars** from **sample** and fill all variables in **terraform.tfvars**

```
cp terraform.tfvars.sample terraform.tfvars
```

### Initalize and apply

These commands will create [k3s](https://k3s.io/) cluster.

```
terraform init
terraform plan
terraform apply
```
After these commands. Terraform will download these files.

**/etc/rancher/k3s/k3s.yaml** to **./data/k3s.yaml** and **/var/lib/rancher/k3s/server/node-token** to **./data/node-token**
```
export KUBECONFIG=`pwd`/data/k3s.yaml
kubectl get nodes
```
You can be able to see details via this command.
```
terraform output
```
### DNS module

if you want to use **cloudflare dns** module.
Please uncomment all lines related to Cloudflare in **dns.tf** and **terraform.tfvars** files.

### Create SSH key (or you can use your own key)

This command will create **id_rsa** and **id_rsa.pub** file in **./data** directory.

```
sh files/create_ssh_key.sh
```
