resource "yandex_storage_bucket" "bucket-hw" {
  bucket = "${lower(var.student_name)}-${formatdate("YYYYMMDD", timestamp())}"
  
  # 
    depends_on = [
    yandex_iam_service_account_static_access_key.sa_key-hw,
    yandex_resourcemanager_folder_iam_binding.role-hw
  ]
  
  acl = "public-read"
  folder_id  = var.folder_id
  access_key = yandex_iam_service_account_static_access_key.sa_key-hw.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_key-hw.secret_key

  anonymous_access_flags {
    read = true
    list = true
  }
}

# добавляем изображение
resource "yandex_storage_object" "picture" {
  access_key = yandex_iam_service_account_static_access_key.sa_key-hw.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_key-hw.secret_key
  bucket       = yandex_storage_bucket.bucket-hw.id
  key          = "kitty.jpg"
  content_type = "image/jpeg"
  source       = "../img/kitty.jpg"
}