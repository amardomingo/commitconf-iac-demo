# CommitConf 2018: Infraestructura como código

Código de la demo para la charla de Iac en la CommitConf 2018

## Prerrequisitos

Es necesario tener terraform instalado, y haber generado la imagen del frontend de demo con packer y la definición de la carpeta `images`

## Demo 1

Crea dos instancias de GCE y un balanceador HTTP usando el modulo de GoogleCloudPlatform.

Para ejecutarla:

```bash
$> cd config
$> terrafom init
$> terraform apply
```

## Demo 2

Igual que la demo anterior, pero añadiendo un nuevo entorno y parametrizando ciertos valores de configuración para reutilizar la configuración

Además, añade un Makefile y un pipeline con circleci para probar los cambios que se realicen.

Para ejecutarlas:
```bash
$> make clean init deploy
```
