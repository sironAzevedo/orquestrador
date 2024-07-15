package br.com.orquestrador.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.io.Serializable;

public interface PayloadResponse {

    record TransactionType(@JsonProperty("Value") String value) implements Serializable{}
    record MessageAttributes(@JsonProperty("transaction_type") TransactionType transactionType) implements Serializable{}
    record Message(String message) implements Serializable{}
    record Dto(@JsonProperty("Message") String message, @JsonProperty("MessageAttributes") MessageAttributes messageAttributes) implements Serializable{}
}
