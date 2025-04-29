resource "yandex_vpc_network" "network-hw" {
  name = "network-hw"
}

resource "yandex_vpc_subnet" "subnet-hw" {
  name           = "subnet-hw"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-hw.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}