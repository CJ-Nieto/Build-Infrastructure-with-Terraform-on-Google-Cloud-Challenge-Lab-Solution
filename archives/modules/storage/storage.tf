
resource "google_storage_bucket" "storage-bucket" {
  name          = "YOUR_BUCKET_NAME"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}
