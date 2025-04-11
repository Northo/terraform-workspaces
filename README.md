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

## Notes

### Deleting a workspace

Delete a workspace with `terraform workspace delete <workspace>`.
Note that the workspace is not deleted until it is actually cleaned up!

```console
❯ terraform workspace delete dev
╷
│ Error: Workspace is not empty
│ 
│ Workspace "dev" is currently tracking the following resource instances:
│   - azurerm_resource_group.rg
│ 
│ Deleting this workspace would cause Terraform to lose track of any associated remote objects, which would then require you to delete them manually outside of
│ Terraform. You should destroy these objects with Terraform before deleting the workspace.
│ 
│ If you want to delete this workspace anyway, and have Terraform forget about these managed objects, use the -force option to disable this safety check.
```

