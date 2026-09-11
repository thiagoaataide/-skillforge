# ORM JAPE (`@JapeEntity`)

Doc: https://developer.sankhya.com.br/docs/mapeamento-relacional

Não use `javax.persistence.*`. Anotações: `br.com.sankhya.studio.persistence.*`.

```java
@Data
@JapeEntity(entity = "Veiculo", table = "TGFVEI")
public class Veiculo {
    @Id
    @Column(name = "CODVEICULO")
    private Long id;

    @Column(name = "PLACA")
    private String placa;

    @Column(name = "ATIVO")
    private boolean ativo;
}
```

A tabela/entidade ainda precisa existir no dicionário (XML manual **ou** AutoDD). Ver [autodd.md](autodd.md).

## PK composta

```java
@Embeddable
public class ItemNotaPK implements Serializable {
    @Column(name = "NUNOTA")
    private Long numeroNota;
    @Column(name = "SEQUENCIA")
    private Integer sequencia;
    // equals + hashCode obrigatórios
}

@JapeEntity(entity = "ItemNota", table = "TGFITE")
public class ItemNota {
    @Id
    private ItemNotaPK id;
}
```

## Relacionamentos

`@OneToMany`: use `relationship = {@Relationship(fromField, toField)}`. **Proibido** `@JoinColumn` no `@OneToMany`. **Proibido** `@Column` no mesmo campo.

```java
@OneToMany(
    cascade = Cascade.ALL,
    relationship = { @Relationship(fromField = "NUNOTA", toField = "NUNOTA") }
)
private List<ItemPedido> itens;

@ManyToOne
@ToString.Exclude
@JoinColumn(name = "NUNOTA", referencedColumnName = "NUNOTA", description = "Número da Nota")
private Pedido pedido;
```

`description` em `@JoinColumn` é obrigatório com AutoDD. FK composta: [foreign-keys.md](foreign-keys.md).

Tipos suportados: primitivos, wrappers, `BigDecimal`, `String`, `Timestamp`, `LocalDate`, `LocalDateTime`, enums. Boolean JAPE grava `S`/`N` via adapter nativo.

Nunca prefixo `AD_`. Prefira o prefixo do addon (`SGT_`, `TDC`, …).
