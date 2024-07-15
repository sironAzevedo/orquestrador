package br.com.orquestrador.model.enums;

import lombok.Getter;

import java.util.Arrays;
import java.util.Objects;

@Getter
public enum JornadaOpenFinanceEnum {
    JORNADA_CONTAS ("JORNADA_CONTAS"),
    JORNADA_CARTAO ("JORNADA_CARTAO"),
    JORNADA_CREDITORIO ("JORNADA_CREDITORIO"),
    JORNADA_EMPRESTIMOS ("JORNADA_EMPRESTIMOS"),
    JORNADA_FINANCIAMENTO ("JORNADA_FINANCIAMENTO"),
    JORNADA_DADOS_CADASTRAIS ("JORNADA_DADOS_CADASTRAIS")
    ;//Adicionar no parameter Store as jornadas no mesmo objeto que informar se é para enviar para o SNS

    private final String descricao;

    JornadaOpenFinanceEnum(final String descricao) {
        this.descricao = descricao;
    }

    public static String from(JornadaOpenFinanceEnum value) {
        JornadaOpenFinanceEnum result = Arrays.stream(JornadaOpenFinanceEnum.values())
                .filter(e -> Objects.nonNull(value) && value.equals(e))
                .findFirst()
                .orElse(null);
        return Objects.nonNull(result) ? result.getDescricao() : null;
    }

    public static JornadaOpenFinanceEnum from(String value) {
        return Arrays.stream(JornadaOpenFinanceEnum.values())
                .filter(e -> Objects.nonNull(value) && value.equalsIgnoreCase(e.getDescricao()))
                .findFirst()
                .orElse(null);
    }
}
