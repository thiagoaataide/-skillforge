# Bean Validation

Doc: https://developer.sankhya.com.br/docs/bean-validation

JSR 303/380. Ativa só com `@Valid` no parâmetro do `@Service` / `@Controller`. Falha → SDK lança antes da lógica.

```java
@Data
public class VeiculoDTO {
    @NotBlank(message = "A placa não pode ser vazia.")
    @Size(min = 7, max = 8, message = "A placa deve ter entre 7 e 8 caracteres.")
    private String placa;

    @NotNull(message = "Status ativo é obrigatório.")
    private Boolean ativo;
}

@Transactional
public Long cadastrar(@Valid VeiculoDTO dto) { ... }
```

| Anotação | Uso |
| --- | --- |
| `@NotNull` | qualquer tipo não nulo |
| `@NotBlank` | String não vazia |
| `@NotEmpty` | coleção/array com elemento |
| `@Size(min, max)` | tamanho |
| `@Min` / `@Max` | número |
| `@Positive` / `@PositiveOrZero` | > 0 / ≥ 0 |
| `@Email` | e-mail |
| `@Pattern(regexp)` | regex |
| `@Future` / `@Past` | datas |
| `@Valid` | cascata em objeto aninhado |

Valide no **DTO de entrada**, não revalide o mesmo no controller com `if`. Mensagens em português, específicas do campo.

Resposta de violação: [controller-advice.md](controller-advice.md).
