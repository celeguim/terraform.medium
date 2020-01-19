# variables.tf
variable "region" {
  default = "us-east-1"
}

variable "availabilityZone" {
  default = "us-east-1a"
}

variable "instanceTenancy" {
  default = "default"
}

variable "dnsSupport" {
  default = true
}

variable "dnsHostNames" {
  default = true
}

variable "vpcCIDRblock" {
  default = "10.0.0.0/16"
}

variable "subnetCIDRblock" {
  default = "10.0.1.0/24"
}

variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}

variable "ingressCIDRblock" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "mapPublicIP" {
  default = true
}

variable vpc_name { default = "My_VPC" }
variable cidr_block_main { default = "192.168.188.0/24" }
# ---
# Network for databases
# HostMin:   192.168.188.5  (first four is reserved by amazon)
# HostMax:   192.168.188.14
variable cidr_block_for_db { default = "192.168.188.0/28" }
# ---
# Network for app services
# HostMin:   192.168.188.21 (first four is reserved by amazon)
# HostMax:   192.168.188.30
variable cidr_block_for_app { default = "192.168.188.16/28" }
# ---
# Network for LB
# HostMin:   192.168.188.37 (first four is reserved by amazon)
# HostMax:   192.168.188.46
variable cidr_block_for_lb { default = "192.168.188.32/28" }
# ---
# Network for Bastion Host
# HostMin:   192.168.188.53 (first four is reserved by amazon)
# HostMax:   192.168.188.62
variable cidr_block_for_bhost { default = "192.168.188.48/28" }
# ---
# Constanstant CIDR blocks
variable cidr_block_internet { default = "0.0.0.0/0" }


# instancies
variable bhost_inst_type  { default = "t2.nano" }
variable bhost_inst_count { default = 1 }
variable app_inst_type { default = "t2.nano" }
variable app_inst_count { default = 1 }
variable app_port { default = 10051 }
variable web_inst_type { default = "t2.nano" }
variable web_inst_min_count { default = 1 }
variable web_inst_max_count { default = 2 }
variable web_http_port { default = 80 }
variable web_https_port { default = 443 }
variable db_inst_type {default = "t2.nano" }
variable db_inst_count { default = 1 }
variable mysql_nofile { default = 10000 }
variable db_password { default = "mypasswd1" }
variable db_port { default = 3306 }
variable elb_listen_http_port { default = 80 }

# end of variables.tf
