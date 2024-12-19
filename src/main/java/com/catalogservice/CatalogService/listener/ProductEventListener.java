package com.catalogservice.CatalogService.listener;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Service
public class ProductEventListener {

    @KafkaListener(topics = "product-events", groupId = "catalog-group")
    public void listenProductEvents(String key, Object value) {
        System.out.println("Recebido evento: Key=" + key + ", Value=" + value);
        // Lógica para processar o evento (ex: salvar logs, replicar dados)
    }
}

