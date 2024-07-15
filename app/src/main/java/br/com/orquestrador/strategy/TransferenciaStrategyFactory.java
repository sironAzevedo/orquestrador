package br.com.orquestrador.strategy;

import br.com.orquestrador.model.PayloadResponse;
import br.com.orquestrador.model.enums.TipoTransferenciaEnum;
import br.com.orquestrador.service.ITransferenciaStrategyService;
import lombok.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.Set;
import java.util.function.Function;

import static java.util.stream.Collectors.toMap;

@Component
public class TransferenciaStrategyFactory {

    private Map<TipoTransferenciaEnum, ITransferenciaStrategyService> strategies;

    @Autowired
    public TransferenciaStrategyFactory(Set<ITransferenciaStrategyService> strategySet) {
        createStrategy(strategySet);
    }

    public void execute(@NonNull TipoTransferenciaEnum transferenciaEnum, @NonNull PayloadResponse.Dto dto) {
        strategies.get(transferenciaEnum).metrica(dto);
    }

    private void createStrategy(Set<ITransferenciaStrategyService> strategySet) {
        this.strategies = strategySet.stream()
                .collect(
                        toMap(k -> k.getClass().getDeclaredAnnotation(TipoTransferenciaAnnotation.class).value(),
                                Function.identity()));
    }
}
