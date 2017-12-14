output "database" {
    value = "${aws_instance.database.public_ip}"
}


# uncomment below sections if there are other nodes in the Cassandra cluster, e.g. the 2nd or the 3rd node
/*
output "cassandra_1" {
  value = "${aws_instance.cassandra_1.public_ip}"
}

output "cassandra_2" {
  value = "${aws_instance.cassandra_2.public_ip}"
}
*/
