package br.com.orquestrador.service;

import br.com.orquestrador.model.PayloadResponse;
import lombok.NonNull;

public interface ITransferenciaStrategyService {

    void metrica(@NonNull PayloadResponse.Dto dto);
}
