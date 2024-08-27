package com.catalogservice.CatalogService.repository;

import com.catalogservice.CatalogService.model.Product;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ProductRepository extends MongoRepository<Product, String> {
}
