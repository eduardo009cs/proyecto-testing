package com.empresa.inventario;

import com.intuit.karate.junit5.Karate;

class InventarioApiTest {

    @Karate.Test
    Karate ejecutarPruebasApi() {
        return Karate.run("classpath:com/empresa/inventario/inventory.feature");
    }
}
