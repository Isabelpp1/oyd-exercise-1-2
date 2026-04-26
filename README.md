# oyd-exercise-1-2

## Tasks completadas

### Task 1 — File separation
Se separó el archivo monolítico `everything.tf` en 7 archivos:
- `provider.tf` — bloque terraform y provider
- `variables.tf` — definición de variables
- `locals.tf` — valores locales
- `main.tf` — recursos
- `outputs.tf` — outputs
- `dev.tfvars` — valores para dev
- `prod.tfvars` — valores para prod

### Task 2 — Parameterize
Se definieron 4 variables en `variables.tf`, cada una con `type` y `description`:
- `environment` — con validation block que solo acepta `dev` o `prod`
- `project_name` — sin default
- `region` — default `us-east-1`
- `bucket_suffix` — sufijo del bucket

### Task 3 — Bucket name en locals.tf
El nombre del bucket se ensambla en `locals.tf`:
- `bucket_name = "${var.project_name}-${var.environment}-${var.bucket_suffix}"`

`main.tf` referencia `local.bucket_name` sin interpolación inline.

### Task 4 — tfvars Files 
Se crearon dos archivos de variables, uno por ambiente:
- `dev.tfvars` — valores para desarrollo
- `prod.tfvars` — valores para producción

Los archivos difieren en tres variables:
| Variable      | dev       | prod      |
|---------------|-----------|-----------|
| environment   | dev       | prod      |
| region        | us-east-1 | us-west-2 |
| bucket_suffix | uploads   | assets    |

### Task 5 — Verify
El resource block section del plan output es el siguiente:

```
  # aws_s3_bucket.main will be created
  + resource "aws_s3_bucket" "main" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "myapp-dev-uploads"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags                        = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Project"     = "myapp"
        }
      + tags_all                    = {
          + "Environment" = "dev"
          + "ManagedBy"   = "terraform"
          + "Project"     = "myapp"
        }
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule (known after apply)

      + grant (known after apply)

      + lifecycle_rule (known after apply)

      + logging (known after apply)

      + object_lock_configuration (known after apply)

      + replication_configuration (known after apply)

      + server_side_encryption_configuration (known after apply)

      + versioning (known after apply)

      + website (known after apply)
    }
```

El nombre del bucket en el plan es myapp-dev-uploads, lo cual coincide exactamente con la expresión en locals.tf: 
```
hclbucket_name = "${var.project_name}-${var.environment}-${var.bucket_suffix}"
```
Con los valores de dev.tfvars: `myapp` + `dev` + `uploads` = myapp-dev-uploads