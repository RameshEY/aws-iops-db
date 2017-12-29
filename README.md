# aws-iops-db (draft, wip)

## Requirements

* Terraform v0.11.0+

## Usage

Clone the repository

```
$ git clone https://github.com/kenzanlabs/aws-iops-db.git
```

Setup a site file

```
$ cd aws-iops-db
$ cat << EOF > iopstest-site
#!/bin/bash

export AWS_DEFAULT_OUTPUT=json
export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCESS_KEY=...
export AWS_SECRET_KEY=...

export iopstest_owner="myname"
export iopstest_vpc_id="vpc-abc1234"
export iopstest_subnet_id="subnet-456ghjk"
export iopstest_aws_region="${AWS_DEFAULT_REGION}"
export iopstest_key_name="awspemkey"
export iopstest_key_path="/absolute/path/to/awspemkey"

export iopstest_datadog_api_key=""  # optional

bash iopstest $*
EOF
```

Run a test

```
$ bash iopstest-site provision database test1
```

Destroy a test

```
$ bash iopstest-site destroy database test1
```

## Notes

* To rerun a test, destroy before provision

## References

* https://github.com/terraform-community-modules/

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
