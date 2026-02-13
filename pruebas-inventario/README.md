# pruebas-inventario

Proyecto Maven configurado para ejecutar pruebas de API con Karate.

## Requisitos

- Java 17+
- Maven 3.9+

## Ejecutar pruebas

Desde el directorio del proyecto:

```bash
cd pruebas-inventario
mvn test
```

O usando el script:

```bash
cd pruebas-inventario
./ejecutar_pruebas.sh
```

El reporte HTML de Karate se genera en `target/karate-reports/`.
