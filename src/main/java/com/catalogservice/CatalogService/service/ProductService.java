package com.catalogservice.CatalogService.service;

import com.catalogservice.CatalogService.model.Product;
import com.catalogservice.CatalogService.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private KafkaTemplate<String, Object> kafkaTemplate;

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public Optional<Product> getProductById(String id) {
        return productRepository.findById(id);
    }

    public Product saveProduct(Product product) {
        productRepository.save(product);
        kafkaTemplate.send("product-events", "Product Created", product);
        return product;
    }

    public void deleteProduct(String id) {
        productRepository.deleteById(id);
    }
}
