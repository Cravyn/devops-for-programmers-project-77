data "vkcs_compute_flavor" "flavor" {
  name = var.compute_flavor
}

data "vkcs_images_image" "image" {
  visibility = "public"
  default    = true
  properties = {
    mcs_os_distro  = "ubuntu"
    mcs_os_version = "24.04"
  }
}

data "vkcs_networking_secgroup" "default_sec_group" {
  name  = "default"
  sdn   = "sprut"
}

data "vkcs_networking_secgroup" "ssh_sec_group" {
  name  = "ssh"
  sdn   = "sprut"
}

data "vkcs_networking_secgroup" "vm_sec_group" {
  name  = "VM_SG"
  sdn   = "sprut"
}

resource "vkcs_compute_instance" "devops1" {
  name                    = "devops-terraform-1"
  flavor_id               = data.vkcs_compute_flavor.flavor.id
  key_pair                = var.key_pair_name
  security_group_ids      = [data.vkcs_networking_secgroup.default_sec_group.id, data.vkcs_networking_secgroup.ssh_sec_group.id, data.vkcs_networking_secgroup.vm_sec_group.id]
  availability_zone       = var.availability_zone_name
  block_device {
    uuid                  = data.vkcs_images_image.image.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 30
    boot_index            = 0
    delete_on_termination = true
  }
  user_data               = <<-EOF
    #!/bin/bash
    set -e  # Выход при ошибках
    
    echo "=== Начало установки Datadog Agent ==="
    
    # Обновление системы и установка зависимостей
    apt-get update
    apt-get install -y curl gnupg lsb-release
    
    # Установка Datadog agent с использованием официального скрипта
    echo "Установка Datadog Agent..."
    DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${var.datadog_api_key} DD_SITE="us3.datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
    
    # Настройка hostname
    echo "Настройка hostname..."
    sed -i 's/# hostname:.*/hostname: devops1/' /etc/datadog-agent/datadog.yaml
    
    # Перезапуск службы для применения настроек
    echo "Перезапуск Datadog agent..."
    systemctl restart datadog-agent
    
    # Ожидание запуска
    echo "Ожидание запуска agent..."
    sleep 15
    
    # Проверка статуса
    echo "Проверка статуса Datadog agent..."
    systemctl status datadog-agent --no-pager
    
    echo "=== Установка Datadog Agent завершена ==="
  EOF
  network {
    uuid = vkcs_networking_network.devops_net.id
  }
  depends_on = [
    vkcs_networking_network.devops_net,
    vkcs_networking_subnet.devops_subnet
  ]
}

resource "vkcs_compute_instance" "devops2" {
  name                    = "devops-terraform-2"
  flavor_id               = data.vkcs_compute_flavor.flavor.id
  key_pair                = var.key_pair_name
  security_group_ids      = [data.vkcs_networking_secgroup.default_sec_group.id, data.vkcs_networking_secgroup.ssh_sec_group.id, data.vkcs_networking_secgroup.vm_sec_group.id]
  availability_zone       = var.availability_zone_name
  block_device {
    uuid                  = data.vkcs_images_image.image.id
    source_type           = "image"
    destination_type      = "volume"
    volume_type           = "ceph-ssd"
    volume_size           = 30
    boot_index            = 0
    delete_on_termination = true
  }
  user_data               = <<-EOF
    #!/bin/bash
    set -e  # Выход при ошибках
    
    echo "=== Начало установки Datadog Agent ==="
    
    # Обновление системы и установка зависимостей
    apt-get update
    apt-get install -y curl gnupg lsb-release
    
    # Установка Datadog agent с использованием официального скрипта
    echo "Установка Datadog Agent..."
    DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${var.datadog_api_key} DD_SITE="us3.datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
    
    # Настройка hostname
    echo "Настройка hostname..."
    sed -i 's/# hostname:.*/hostname: devops2/' /etc/datadog-agent/datadog.yaml
    
    # Перезапуск службы для применения настроек
    echo "Перезапуск Datadog agent..."
    systemctl restart datadog-agent
    
    # Ожидание запуска
    echo "Ожидание запуска agent..."
    sleep 15
    
    # Проверка статуса
    echo "Проверка статуса Datadog agent..."
    systemctl status datadog-agent --no-pager
    
    echo "=== Установка Datadog Agent завершена ==="
  EOF
  network {
    uuid                  = vkcs_networking_network.devops_net.id
  }
  depends_on              = [
    vkcs_networking_network.devops_net,
    vkcs_networking_subnet.devops_subnet
  ]
}