# Repositório (`@Repository`)

Doc: https://developer.sankhya.com.br/docs/repositorio-dados

```java
import br.com.sankhya.sdk.data.repository.JapeRepository;
import br.com.sankhya.studio.stereotypes.Repository;

@Repository
public interface VeiculoRepository extends JapeRepository<Long, Veiculo> {

    @Criteria(clause = "this.ATIVO = 'S' AND this.PLACA LIKE :placa")
    List<Veiculo> findAtivosPorPlaca(@Parameter(name = "placa") String placa);

    @Criteria(clause = "this.ATIVO = :ativo")
    Page<Veiculo> findByAtivoPaginado(
        @Parameter(name = "ativo") Boolean ativo,
        Pageable pageable
    );
}
```

Ordem dos genéricos: **`JapeRepository<ID, Entity>`**. A documentação oficial às vezes inverte; compile contra o jar se o projeto já tiver repositórios.

CRUD herdado: `save`, `findByPK`, `findAll`, `findAll(Pageable)`, `delete`. Métodos herdados podem lançar `Exception` checada — respeite as assinaturas do projeto (alguns templates usam `Optional`, o jar 2.0 pode devolver `T` nullable). Siga o que já existe no código.

## Consultas

- **`@Criteria`**: WHERE JAPE. Prefixe `this.CAMPO`. Parâmetros nomeados.
- **`@NativeQuery`**: SQL nativo, macros Sankhya, DTO com `@NativeQuery.Result`.
- **Não existem** query methods Spring (`findByPlacaStartingWith`).
- **`@Delete` descontinuado.** Use:

```java
@Modifying
@NativeQuery("DELETE FROM AD_LOGS WHERE DTEXPIRACAO < :data")
int excluirLogsExpirados(@Parameter(name = "data") LocalDate data);
```

`@Modifying` só dentro de `@Transactional`. Retorno `int`/`Integer`/`void`.

DTO nativo: getters devem casar **exatamente** com alias da query.

```java
@NativeQuery.Result
public interface ResumoProdutoDTO {
    Long getCodigo();
    String getDescricao();
}

@NativeQuery("SELECT CODPROD AS Codigo, DESCRPROD AS Descricao FROM TGFPRO WHERE ATIVO = 'S'")
List<ResumoProdutoDTO> listarProdutosAtivos();
```

Paginação: sessão JAPE limita ~500 linhas. Listagens grandes → `Pageable` / `PageRequest`.

SQL em arquivo: use quando a query passar de dezenas de linhas; mantenha variantes Oracle/MSSQL via macros, não duas queries hardcoded. Ver [macros.md](macros.md).
