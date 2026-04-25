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