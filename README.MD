# Terraform Design

Three Step Process [Any shorter will make things complicated]

## Overview
```text
1. Create Manually a S3 Bucket
    a. core-terraform-state
        i. make sure you have replica and version enabled.
    b.access-flow-bucket-tt
        i. make sure Logging ACL is enabled
        ii. make sure you have replica and version enabled.
2. Brain of the Project
    a. S3 Buckets which are needed
        i. vpc Log flow Bucket
        ii. Access Log
3. Everything else
```
## Details
```text
1. If we dont do first step and ask terraform to do then it becomes cyclic dependency
    a. S3 bucket needs terraform and terraform needs s3
    b. mistakely deleting the core state is dangerous. 
2. Terraform has a tricky problem deleting s3 buckets not empty, but also think we dont want to lose data
   when rebuilding infra, so best keep them outside and reuse same buckets.
3. Make lot of modules and wire them up in the last step.
```


terraform output -module=TF_Module_S3_VPC_Bucket