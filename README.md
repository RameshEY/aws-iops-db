# aws-iops-db

## Planned Usage

$ git clone https://github.com/kenzanlabs/aws-iops-db.git
$ cd aws-iops-blog/
$ export TF_VAR_key_name="keyname.pem"
$ export TF_VAR_vpc_name="vpc-abc1234"
$ export TF_VAR_subnet_name="subnet-abc1234"

$ bash iops-run-test cassandra test1,test2,...
$ bash iops-run-test mongoDB test1,test2,...
provisioning test1
database: mongoDB
machine: r4.4xlarge 1TB gp2
   \_ $ terraform database
   \_ $ terraform ycsb instance...

run test1..
   \_ $ ycsb load
   \_ $ ycsb run command

...


## LICENSE
Copyright 2017 Kenzan, LLC <http://kenzan.com>
 
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
 
    http://www.apache.org/licenses/LICENSE-2.0
 
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
