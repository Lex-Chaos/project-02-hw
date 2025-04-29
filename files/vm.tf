resource "yandex_compute_instance_group" "group-hw" {
  name               = "instance-group-hw"
  folder_id          = var.folder_id
  service_account_id = yandex_iam_service_account.sa-hw.id

  instance_template {
    platform_id = "standard-v3"
    resources {
      cores  = 2
      memory = 2
    }

    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"  
      }
    }

    network_interface {
      network_id = "${yandex_vpc_network.network-hw.id}"
      subnet_ids = ["${yandex_vpc_subnet.subnet-hw.id}"]
      nat        = true  
    }

    metadata = {
      user-data = templatefile("${path.module}/user_data.yml", {
        image_url = local.image_url
        ssh_key   = file(var.ssh_key_path) 
      }) 
      ssh-keys  = "lex:${file(var.ssh_key_path)}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3  
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 3
    max_expansion   = 3
    max_creating    = 3
    max_deleting    = 3
  }

  health_check {
    http_options {
      port = 80
      path = "/"
    }
  }

  load_balancer {
    target_group_name = "target-instance-group"
  }
}