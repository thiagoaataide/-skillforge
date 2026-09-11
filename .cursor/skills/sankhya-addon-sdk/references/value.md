# `@Value` — injeção de valores

Doc: https://developer.sankhya.com.br/docs/inje%C3%A7%C3%A3o-de-valores-value

Não use `MGECoreParameter.getParameter` nem `System.getenv` espalhado. Injete.

```java
@Service(serviceName = "PedidoServiceSP")
public class PedidoService {

    @Value(value = "server.port", type = ValueType.SYSTEM_PROPERTY, defaultValue = "8080")
    private Integer serverPort;

    @Value(value = "DATABASE_URL", type = ValueType.ENV_VAR, defaultValue = "jdbc:h2:mem:test")
    private Provider<String> databaseUrl;

    @Value(param = "MAX_CONNECTIONS", type = ValueType.SANKHYA_PARAM, defaultValue = "10")
    private Provider<Integer> maxConnections;
}
```

| `ValueType` | Atributo | Fonte |
| --- | --- | --- |
| `SYSTEM_PROPERTY` | `value` | `-D` / `System.getProperty` |
| `ENV_VAR` | `value` | ambiente / `.env` |
| `SANKHYA_PARAM` | `param` | parâmetro do Om |

- Campo direto = eager (na construção).
- `Provider<T>` = lazy + cache. Prefira para parâmetro Sankhya e feature flag.
- Sempre `defaultValue` quando a ausência for aceitável.
