# Foreign keys compostas

Doc: https://developer.sankhya.com.br/docs/foreign-keys-compostas

| Relacionamento | Mapeamento |
| --- | --- |
| `@ManyToOne` / `@OneToOne` | `@JoinColumn` ou `@JoinColumns` |
| `@OneToMany` | `relationship = {@Relationship(...)}` — **nunca** `@JoinColumn` |

```java
@ManyToOne
@JoinColumn(
    name = "CODPARC",
    referencedColumnName = "CODPARC",
    description = "Código do Parceiro" // obrigatório com AutoDD
)
private Parceiro parceiro;

@ManyToOne
@JoinColumns({
    @JoinColumn(name = "NUNOTA", referencedColumnName = "NUNOTA", description = "Num. Nota"),
    @JoinColumn(name = "SEQUENCIA", referencedColumnName = "SEQUENCIA", description = "Sequencia Item")
})
private ItemNota itemNota;
```

PK simples apontando para PK composta:

```java
@OneToOne
@JoinColumns({
    @JoinColumn(name = "FK_COL1", referencedColumnName = "COL1", description = "Coluna 1"),
    @JoinColumn(name = "FK_COL2", referencedColumnName = "COL2", description = "Coluna 2")
})
private ChaveComposta chaveComposta;
```

Mantenha a mesma ordem em `@JoinColumns` e `@Embeddable`. Prefira `Cascade.CREATE` + `Cascade.MERGE` a `Cascade.ALL` em FKs compostas.
