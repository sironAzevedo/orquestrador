package br.com.orquestrador.mensageria.producer;

import br.com.orquestrador.model.PayloadResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class MotorQualidadeProducer {

    @Value(value = "${events.kafka.topic.motor-qualidade}")
    private String topic;

    private final KafkaTemplate<String, String> kafkaTemplate;

    public void send(PayloadResponse.Dto payload) {
        log.info("Enviando informção para o topico kafka: {}", topic);
        this.kafkaTemplate.send(topic, payload.message());
    }
}
