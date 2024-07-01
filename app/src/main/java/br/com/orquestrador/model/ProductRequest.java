package br.com.orquestrador.model;

public record ProductRequest(
        String nomeProduto,
        String token,
        String correlationId,
        String numeroConta,
        String uri
) {
}
