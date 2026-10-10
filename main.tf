
locals {
  tiers = {
    bronze = "Raw source data"
    silver = "Cleaned and validated data"
    gold   = "Curated business data"
  }
}

resource "google_storage_bucket" "tier" {
  for_each = local.tiers

  name     = "${var.bucket_prefix}-${each.key}"
  project  = var.project_id
  location = var.region

  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  labels = {
    environment = "dev"
    layer       = each.key
    managed_by  = "terraform"
  }

  lifecycle_rule {
    condition {
      age = 90
    }

    action {
      type = "Delete"
    }

    # Disabled by default: uncomment the rule only
    # if automatic deletion after 90 days is required.
  }
}
