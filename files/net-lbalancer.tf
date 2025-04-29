resource "yandex_lb_network_load_balancer" "net-balancer-hw" {
  name = "hw-balancer"

  listener {
    name = "http-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.group-hw.load_balancer.0.target_group_id

    healthcheck {
      name = "http-healthcheck"
      http_options {
        port = 80
        path = "/index.html"
      }
    }
  }
}