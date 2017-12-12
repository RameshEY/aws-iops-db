# aws-iops-db (draft, wip)

## Requirements

* Terraform v0.11.0+

## Usage

Setup Site Variables

```
$ export AWS_CONFIG_FILE=...
$ export AWS_DEFAULT_OUTPUT=json
$ export AWS_DEFAULT_REGION=us-east-1
$ export AWS_ACCESS_KEY=...
$ export AWS_SECRET_KEY=...

$ export iopstest_owner="myname"
$ export iopstest_vpc_id="vpc-abc1234"
$ export iopstest_subnet_id="subnet-456ghjk"
$ export iopstest_aws_region="us-east-1"
$ export iopstest_key_name="mykeyname
$ export iopstest_key_path="/path/to/mykeyname.pem"
```

Run a test

```
$ git clone https://github.com/kenzanlabs/aws-iops-db.git
$ cd aws-iops-blog/

$ bash iopstest provision database test,test2 # partial implemented
```

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
