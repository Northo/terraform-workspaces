# Learning Terraform Workspaces

This simple setup handles two environments, `dev` and `prod`.
Which is set up is managed by varaibles (`terraform apply -var-file [dev|prod].tfvars`).

However, running just that will remove dev (prod) when setting up prod (dev), as the state is overwritten.
That's where [workspaces](https://developer.hashicorp.com/terraform/cli/workspaces) come in!

We can add a new `dev` workspace.

## Running 

Set the subscription id `export ARM_SUBSCRIPTION_ID=00000000-xxxx-xxxx-xxxx-xxxxxxxxxxxx` and run `terraform init`

1. Set up prod

    ```console
    terraform apply -var-file prod.tfvars
    ```

2. Set up dev
    
    ```console
    terrraform workspace new dev
    terraform apply -var-file dev.tfvars
    ```

