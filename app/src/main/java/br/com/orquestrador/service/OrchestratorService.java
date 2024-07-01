package br.com.orquestrador.service;

import br.com.orquestrador.model.ProductRequest;
import br.com.orquestrador.model.ProductResponse;
import org.springframework.stereotype.Service;

@Service
public class OrchestratorService {
    public ProductResponse orchestrate(ProductRequest productRequest) {
        return new ProductResponse(productRequest.nomeProduto(), productRequest.uri());
    }
}
