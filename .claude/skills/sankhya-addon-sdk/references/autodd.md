# AutoDD

Doc: https://developer.sankhya.com.br/docs/autodd-gera%C3%A7%C3%A3o-autom%C3%A1tica-do-dicion%C3%A1rio-de-dados-data-dictionary

Gera XML de **Table** e **NativeTable** a partir de `@JapeEntity`. Não cobre views, menus, dashboards, tree tables, filters.

```groovy
addon {
    autoDD = true
    autoDDL = true
}
```

```java
@Data
@NoArgsConstructor
@JapeEntity(entity = "TST_MinhaClasse", table = "TST_MINHA_CLASSE", description = "Minha Classe Exemplo")
public class MinhaClasse {
    @Id
    @GeneratedValue(strategy = GeneratedValue.GenerationType.AUTO)
    @Column(name = "ID", dataType = DataType.INTEGER, description = "Id")
    private Long id;

    @Column(name = "MSG", dataType = DataType.TEXT, description = "Mensagem")
    private String mensagem;
}
```

Tabela nativa:

```java
@JapeEntity(
    entity = "TST_InstanciaCustomizadaUsuarios",
    table = "TSIUSU",
    description = "Instância Customizada de Usuários",
    isNativeTable = true,
    isNativeInstance = false
)
public class InstanciaCustomizadaUsuarios { ... }
```

Com AutoDD, preencha `description` e `dataType` nas colunas. Relacionamentos: [orm.md](orm.md) e [foreign-keys.md](foreign-keys.md).

Fluxo: anotar entidade → `./gradlew clean deployAddon` → XML na pasta de build → AutoDDL gera scripts. Revise DDL antes de produção.

Se AutoDD estiver **desligado**, continue gerando XML em `model/src/main/resources/datadictionary` (skill `data-dictionary` / metadados.xsd).
