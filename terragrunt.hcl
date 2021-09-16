locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  env   = local.environment_vars.locals.environment
  project = "ingka-dp-sap-${local.env}"
}

remote_state {
    backend = "gcs"
    config = {
        bucket    = "int_s2p_005_poc-tfstate-${local.env}"
        prefix    = "${path_relative_to_include()}/terraform.tfstate"
        project   = "${local.project}"
        location  = "europe-west1"
    }
}

inputs = {
  topic_name = "ingka-s2p-sapfin-purchaseorder-unifier_poc"
  iam_roles = [
    "roles/pubsub.publisher",
    "roles/pubsub.subscriber"
  ]
  iam_members = {
    "roles/pubsub.publisher"  = ["serviceAccount:ingka-sa-sap-ingestion@ingka-dp-sap-${local.env}.iam.gserviceaccount.com"]
    "roles/pubsub.subscriber" = ["serviceAccount:ingka-sa-unifier-external@ingka-dp-unifier-${local.env}.iam.gserviceaccount.com"]
  }
}



generate "provider"{
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  terraform {
    backend "gcs"{}
    }
    EOF
}

