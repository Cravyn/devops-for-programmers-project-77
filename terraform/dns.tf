resource "vkcs_publicdns_zone" "zone" {
  zone        = "cravyn.ru"
  primary_dns = "ns1.mcs.mail.ru"
  admin_email = var.login
  expire      = 3600000
}

resource "vkcs_publicdns_record" "main_record" {
  zone_id  = vkcs_publicdns_zone.zone.id
  type     = "A"
  name     = "@"
  ip       = vkcs_networking_floatingip.lb_fip.address
  ttl      = 60
}

resource "vkcs_publicdns_record" "www_record" {
  zone_id  = vkcs_publicdns_zone.zone.id
  type     = "A"
  name     = "www.cravyn.ru"
  ip       = vkcs_networking_floatingip.lb_fip.address
  ttl      = 60
}

resource "vkcs_publicdns_record" "txt_record" {
  zone_id   = vkcs_publicdns_zone.zone.id
  type      = "TXT"
  name      = "@"
  content   = "_globalsign-domain-verification=Tc1PJWlmb3jynP5TxkWS1949UK_IdZYgA34W6ttLQE"
  ttl       = 60
}
