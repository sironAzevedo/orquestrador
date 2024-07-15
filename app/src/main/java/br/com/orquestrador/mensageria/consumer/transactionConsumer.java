package br.com.orquestrador.mensageria.consumer;

import br.com.orquestrador.mensageria.producer.MotorQualidadeProducer;
import br.com.orquestrador.model.PayloadResponse.Dto;
import br.com.orquestrador.model.enums.TipoTransferenciaEnum;
import br.com.orquestrador.strategy.TransferenciaStrategyFactory;
import io.awspring.cloud.messaging.listener.SqsMessageDeletionPolicy;
import io.awspring.cloud.messaging.listener.annotation.SqsListener;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.Message;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class transactionConsumer {

    private final TransferenciaStrategyFactory transferenciaStrategyFactory;
    private final MotorQualidadeProducer motorQualidadeProducer;

    @SqsListener(value = "${events.sqs.queue}", deletionPolicy = SqsMessageDeletionPolicy.ON_SUCCESS)
    public void consume(Message<String> message) {

        log.info("message consumed {}", message);
        var payload = com.br.azevedo.utils.JsonUtils.jsonToObject(message.getPayload(), Dto.class);
        var tipoTransacao = TipoTransferenciaEnum.from(payload.messageAttributes().transactionType().value());
        transferenciaStrategyFactory.execute(tipoTransacao, payload);
        motorQualidadeProducer.send(payload);
    }
}
