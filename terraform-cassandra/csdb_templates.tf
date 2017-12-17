resource "template_dir" "database_config" {

  source_dir      = "csdb_templates"
  destination_dir = "csdb_templates_rendered"

  vars {
    database_cluster_name = "ycsb"
    database_private_ip   = "${aws_instance.database.private_ip}"
  }   
}
