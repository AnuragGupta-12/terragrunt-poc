locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.environment_vars.locals.environment
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:ingka-group-digital/dpfw-terraform-modules.git//pubsub/topic?ref=v2.0.22"
}

inputs = {
  project_id = "ingka-dp-sap-${local.env}"
  environment = "${local.env}"
  #topic_name = "ingka-s2p-sapfin-purchaseorder-unifier_anu"
}
