locals {

    resource_tags = {
        resource_group_name = var.grafanaresourcegroup
        storage_account = var.storageaccount
        networkingresourcegroup = var.networkingresourcegroup
        vm_name = var.vm_name
        vn_name = var.vn_name
        logs = var.logs
        ni = var.ni
        sname = var.sname

    }
}