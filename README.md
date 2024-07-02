# Solución del Quicklab "Build Infrastructure with Terraform on Google Cloud Challenge Lab"

## Exportar los nombres del bucket, inatancia y vpc, así como la zona. Posteriormente descargar el script.

```bash
export BUCKET_NAME=

export INSTANCE_NAME=

export VPC_NAME=

export ZONE=

curl -LO raw.githubusercontent.com/CJ-Nieto/Build-Infrastructure-with-Terraform-on-Google-Cloud-Challenge-Lab-Solution/main/quicklab345.sh

sudo chmod +x quicklab345.sh

./quicklab345.sh
```

Los nombres del bucket, inatancia y vpc, se encuentran en la parte de los datos de ingreso a la VM (lado izquierdo).

<p align="center">
  <img width="auto" height="auto" src="https://github.com/CJ-Nieto/Build-Infrastructure-with-Terraform-on-Google-Cloud-Challenge-Lab-Solution/blob/main/imgs/export.png">
</p>

La zona se encuentra en el segundo punto de la _Tarea 1. Crea los archivos de configuración_.

<p align="center">
  <img width="auto" height="auto" src="https://github.com/CJ-Nieto/Build-Infrastructure-with-Terraform-on-Google-Cloud-Challenge-Lab-Solution/blob/main/imgs/export_zone.png">
</p>

---
>[!IMPORTANT]
>### Si se muestra el error: ```./quicklab345.sh: line 1: 404:: command not found```.

Puede que este relacionado con caracteres de retorno de carro (\r) en el archivo ```quicklab345.sh```. Estos caracteres pueden causar problemas al ejecutar scripts en sistemas Unix/Linux.
Para solucionar esto, necesitas eliminar los caracteres ```\r``` del archivo.

1.- Instala dos2unix (si no lo tienes instalado):
```bash
sudo apt-get install dos2unix
```

2.- Convierte el archivo a formato Unix:
```bash
dos2unix quicklab345.sh
```

3.- Vuelve a asignar permisos ejecutables al archivo:
```bash
chmod +x quicklab345.sh
```

4.- Ejecuta el script nuevamente:
```bash
./quicklab345.sh
```

---
>[!IMPORTANT]
>### Si no se crean las instancias puede que la imagen del disco de arranque no se encuentre en el proyecto de Google Cloud.

1.- Para ello validar la lista de discos:
```bash
gcloud compute images list
```

2.- Una vez localizado el nombre de la imagen que se desea usar reemplazarlo en el archivo ```instances.tf```. Por ejemplo:
```
# instances.tf
resource "google_compute_instance" "tf-instance-1" {
  # ...
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"  # Cambia a la imagen que deseas
    }
  }
  # ...
}
```

3.- Posteriormente inicializar tu directorio de trabajo nuevamente. Esto descargará los proveedores y configurará el backend según lo especificado en el archivo de configuración:
```bash
terraform init
```

4.- Después de ejecutar ```terraform init```, puedes aplicar tus configuraciones.
Terraform verificará los cambios y te mostrará un resumen de lo que se creará, actualizará o eliminará:
```bash
terraform apply
```

>[!NOTE]
>Confirma la aplicación de los cambios escribiendo “```yes```” cuando se te solicite.

---
## Verifica los recursos creados, es decir valida que al hacer clic en "```Revisar mi progreso```" se verifique el objetivo.
