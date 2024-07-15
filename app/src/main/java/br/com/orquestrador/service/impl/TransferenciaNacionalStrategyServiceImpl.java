package br.com.orquestrador.service.impl;

import br.com.orquestrador.model.PayloadResponse;
import br.com.orquestrador.model.enums.TipoTransferenciaEnum;
import br.com.orquestrador.service.ITransferenciaStrategyService;
import br.com.orquestrador.strategy.TipoTransferenciaAnnotation;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@TipoTransferenciaAnnotation(TipoTransferenciaEnum.NACIONAL)
public class TransferenciaNacionalStrategyServiceImpl implements ITransferenciaStrategyService {

    @Value(value = "${events.kafka.topic.transaction-nacional}")
    private String topic;
    private final KafkaTemplate<String, String> kafkaTemplate;

    @Override
    public void metrica(PayloadResponse.@NonNull Dto dto) {
        log.info("Processando as transações Nacionais: {}", dto);

        log.info("Enviando informção para o topico kafka: {}", topic);
        this.kafkaTemplate.send(topic, dto.message());

    }
}
