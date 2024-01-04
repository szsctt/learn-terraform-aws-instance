# Creating an EC2 instance with Terraform

This terraform script creates an ubuntu EC2 instance, including all necessary networking components so the instance can be accessed via ssh.

First, if it doesn't already exist, create an ssh key and save it to the file `~/.ssh/id_ed25519`:

```
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Set environment variables with an AWS acccess key and secret access key:
```
export AWS_ACCESS_KEY_ID=<access key>
export AWS_SECRET_ACCESS_KEY=<secret key>
```

Create the necessary resources:
```
terraform apply
```

The public IP address will be printed after the instance is created.  Use this to ssh to the machine:

```
ssh -i ~/.ssh/id_ed25519 ubuntu@<public_ip>
```

Destroy all resources with terraform:

```
terraform destroy
```
