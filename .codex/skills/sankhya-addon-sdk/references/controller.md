# Controller (`@Controller`)

Doc: https://developer.sankhya.com.br/docs/camada-de-controller-controller

`@Controller` é alias semântico de `@Service`: ponto de entrada da API interna. Só orquestra. Sem regra de negócio, sem acesso direto a repositório.

```java
@Controller(serviceName = "EstoqueControllerSP")
public class EstoqueController {

    private final EstoqueBusiness estoqueBusiness;
    private final EstoqueMapper estoqueMapper;

    @Inject
    public EstoqueController(EstoqueBusiness estoqueBusiness, EstoqueMapper estoqueMapper) {
        this.estoqueBusiness = estoqueBusiness;
        this.estoqueMapper = estoqueMapper;
    }

    @Transactional
    public EstoqueDTO atualizarEstoque(@Valid AtualizarEstoqueRequestDTO requestDTO) {
        Estoque estoque = estoqueBusiness.processarAtualizacao(requestDTO);
        return estoqueMapper.toDTO(estoque);
    }

    public List<EstoqueDTO> listarPorProduto(BigDecimal codProduto) {
        return estoqueBusiness.listarPorProduto(codProduto);
    }
}
```

## Contrato

- `serviceName` **obrigatório**, sufixo `SP`.
- Métodos **públicos** viram ações: `serviceName.nomeMetodo`.
- Entrada e saída = DTOs. Nunca `@JapeEntity`.
- Escrita: `@Transactional`. Leitura: omitir, ou `transactionType` de classe.

## URL

```
<dns>/<rootProject.name>/service.sbr?serviceName=<serviceName>.<metodo>&mgeSession=<jsessionId>
```

Login (ambiente sem Gateway):

```bash
curl --location 'http://localhost:8080/mge/service.sbr?serviceName=MobileLoginSP.login&outputType=json' \
  --header 'Content-Type: application/json' \
  --data '{"requestBody":{"NOMUSU":{"$":"USUARIO"},"INTERNO":{"$":"SENHA"}}}'
```

No Gateway, `MobileLogin` não é necessário.

## Envelope JSON

Request: cada parâmetro Java vira chave em `requestBody`.

```json
{
  "serviceName": "PedidoControllerSP.criarPedido",
  "requestBody": {
    "pedido": { "observacao": "Urgente" }
  }
}
```

Sucesso: `status = "1"`. Erro: `status = "0"` e mensagem em `statusMessage` (sem `@ControllerAdvice`) ou corpo tratado pelo advice.

## Transação na classe

Docs oficiais usam `TransactionType` no `@Controller`:

| Valor | Uso |
| --- | --- |
| `Supported` (padrão) | Mistura leitura/escrita |
| `Required` | Só escrita |
| `NotSupported` | Só leitura |

`@Transactional` no método **vence** o padrão da classe.

## Proibido

- Retornar entidade.
- `try/catch` de negócio (deixe [controller-advice.md](controller-advice.md)).
- `serviceName` sem `SP`.
- Colocar `@Component` no mesmo tipo que já é `@Controller`.
