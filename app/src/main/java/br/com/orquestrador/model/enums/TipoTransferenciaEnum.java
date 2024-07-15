package br.com.orquestrador.model.enums;

import lombok.Getter;

import java.util.Arrays;
import java.util.Objects;

@Getter
public enum TipoTransferenciaEnum {
    NACIONAL ("NACIONAL"),
    INTERNACIONAL ("INTERNACIONAL");

    private final String descricao;

    TipoTransferenciaEnum(final String descricao){
        this.descricao = descricao;
    }

    public static String from(TipoTransferenciaEnum value) {
        TipoTransferenciaEnum result = Arrays.stream(TipoTransferenciaEnum.values())
                .filter(e -> Objects.nonNull(value) && value.equals(e))
                .findFirst()
                .orElse(null);
        return Objects.nonNull(result) ? result.getDescricao() : null;
    }

    public static TipoTransferenciaEnum from(String value) {
        return Arrays.stream(TipoTransferenciaEnum.values())
                .filter(e -> Objects.nonNull(value) && value.equalsIgnoreCase(e.getDescricao()))
                .findFirst()
                .orElse(null);
    }
}
