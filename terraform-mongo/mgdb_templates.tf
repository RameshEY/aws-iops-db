resource "template_dir" "database_config" {

  source_dir      = "mgdb_templates"
  destination_dir = "mgdb_templates_rendered"

  vars {

    DEVICE_NAME          = "xvdh"

    mongodb_username     = "${var.mongodb_username}"
    mongodb_version      = "${var.mongodb_version}"
    mongodb_basedir      = "${var.mongodb_basedir}"
    mongodb_conf_engine  = "${var.mongodb_conf_engine}"
    mongodb_conf_logpath = "${var.mongodb_conf_logpath}"

    aws_region           = "${var.mgdb_aws_region}"
    config_ephemeral     = "${var.config_ephemeral}"
    config_ebs           = "${var.config_ebs}"

    database_private_ip  = "${aws_instance.database.private_ip}"
  }
}
