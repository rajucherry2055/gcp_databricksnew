
output "storage_bucket_names" {
  description = "GCS buckets created for the three-tier architecture"

  value = {
    for tier, bucket in google_storage_bucket.tier :
    tier => bucket.name
  }
}
