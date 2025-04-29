output "instance_ips" {
  value = [
    for instance in yandex_compute_instance_group.group-hw.instances : instance.network_interface[0].nat_ip_address
  ]
}

output "image_url" {
  value = local.image_url
}

output "balancer_ip" {
  value = yandex_lb_network_load_balancer.net-balancer-hw.listener[*].external_address_spec[*].address
}