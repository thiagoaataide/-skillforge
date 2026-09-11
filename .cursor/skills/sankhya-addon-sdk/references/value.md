# `@Value` — injeção de valores

Doc: https://developer.sankhya.com.br/docs/inje%C3%A7%C3%A3o-de-valores-value

Não use `MGECoreParameter.getParameter`, `System.getenv` nem `Integer.parseInt` de config no método. Injete no campo de um `@Component` / `@Service` / `@Controller`. Campo **não** pode ser `final`. Classe **não** pode ser criada com `new`.

`type` e `defaultValue` são **obrigatórios**. Informe `value` **ou** `param` (se os dois existirem, `param` vence).

```java
@Value(
    value = "PROPERTY_NAME",
    param = "PROPERTY_NAME",
    group = "GROUP_NAME",
    type = ValueType.ENV_VAR,
    defaultValue = "default"
)
```

| Atributo | Obrigatório | Uso |
| --- | --- | --- |
| `value` | um dos dois | nome da propriedade (`ENV_VAR`, `SYSTEM_PROPERTY`) |
| `param` | um dos dois | nome do parâmetro Sankhya (vence `value`) |
| `group` | não | só com `SANKHYA_PARAM` |
| `type` | sim | fonte |
| `defaultValue` | sim | fallback (string; SDK converte) |

---

## Tipos de injeção (eager vs lazy)

São **dois** modos, definidos pelo tipo do **campo**, não pelo `ValueType`.

| | Eager (direta) | Lazy com cache (**recomendado** para opcional) |
| --- | --- | --- |
| Campo | `private Integer serverPort` | `private Provider<Integer> maxConnections` |
| Quando resolve | construção do objeto | primeira chamada a `.get()` |
| Cache | já resolvido | sim, depois do primeiro `get()` |
| Use quando | config sempre necessária na subida | feature flag, URL, parâmetro que pode nem ser lido |

### Eager — valor na construção

```java
@Component
public class DatabaseConfig {

    @Value(value = "server.port", type = ValueType.SYSTEM_PROPERTY, defaultValue = "8080")
    private Integer serverPort;

    @Value(value = "debug.enabled", type = ValueType.SYSTEM_PROPERTY, defaultValue = "false")
    private Boolean debugEnabled;

    @Value(value = "app.name", type = ValueType.ENV_VAR, defaultValue = "MyApp")
    private String appName;

    public void initialize() {
        // já convertidos; sem .get()
        int porta = serverPort;
        boolean debug = debugEnabled;
    }
}
```

### Lazy — `Provider<T>` + `.get()`

```java
@Component
public class ServiceConfig {

    @Value(value = "DATABASE_URL", type = ValueType.ENV_VAR, defaultValue = "jdbc:h2:mem:test")
    private Provider<String> databaseUrl;

    @Value(param = "MAX_CONNECTIONS", type = ValueType.SANKHYA_PARAM, defaultValue = "10")
    private Provider<Integer> maxConnections;

    @Value(param = "FEATURE_FLAG", type = ValueType.SANKHYA_PARAM, defaultValue = "false")
    private Provider<Boolean> featureFlag;

    public void conectar() {
        if (featureFlag.get()) {
            String url = databaseUrl.get();
            int max = maxConnections.get();
            conectar(url, max);
        }
        // se a flag for false, URL e pool nem são resolvidos
    }
}
```

`databaseUrl.get()` na 2ª vez lê o cache da instância. Não espera parâmetro Sankhya mudar em runtime.

Na geração de código: parâmetro do Om e feature flag → `Provider<T>`. Porta, ambiente, nome do app que o construtor já usa → campo direto.

---

## Fontes (`ValueType`)

### `ENV_VAR` — variável de ambiente / `.env`

Atributo: `value` = nome da variável.

```java
@Value(value = "DATABASE_URL", type = ValueType.ENV_VAR, defaultValue = "jdbc:h2:mem:test")
private Provider<String> databaseUrl;

@Value(value = "API_KEY", type = ValueType.ENV_VAR, defaultValue = "")
private String apiKey;
```

### `SYSTEM_PROPERTY` — `-D` / `System.getProperty`

Atributo: `value` = chave Java (pode ter ponto).

```java
@Value(value = "server.port", type = ValueType.SYSTEM_PROPERTY, defaultValue = "8080")
private Integer serverPort;

@Value(value = "debug.enabled", type = ValueType.SYSTEM_PROPERTY, defaultValue = "false")
private Boolean debugEnabled;
```

### `SANKHYA_PARAM` — parâmetro do Om (`MGECoreParameter`)

Atributo: `param` (não `value`). `group` opcional.

```java
@Value(param = "MAX_CONNECTIONS", type = ValueType.SANKHYA_PARAM, defaultValue = "10")
private Provider<Integer> maxConnections;

@Value(param = "TIMEOUT", group = "CONNECTION", type = ValueType.SANKHYA_PARAM, defaultValue = "30")
private Provider<Long> connectionTimeout;

@Value(param = "RETRY_COUNT", group = "HTTP", type = ValueType.SANKHYA_PARAM, defaultValue = "3")
private Integer retryCount;
```

### `UNDEFINED` — sempre o default

```java
@Value(value = "fallback", type = ValueType.UNDEFINED, defaultValue = "default-value")
private String fallbackValue;
```

Útil em teste. Não use em produção no lugar de parâmetro real.

---

## Tipos Java convertidos

`defaultValue` é `String`. O SDK converte para o tipo do campo.

| Campo | Exemplo de default |
| --- | --- |
| `String` | `"smtp.gmail.com"` |
| `Integer` / `int` | `"8080"` |
| `Boolean` / `boolean` | `"false"` |
| `Long` / `long` | `"30"` |
| `Double` / `double` | `"3.14"` |
| `Float` / `float` | `"0.05"` |
| `Provider<T>` | os mesmos, como genérico |

Não injete `String` para depois fazer `Integer.parseInt`. Use `Integer`.

---

## Exemplos para gerar código

### Pedido (eager + lazy no mesmo service)

```java
@Service(serviceName = "PedidoServiceSP")
public class PedidoService {

    @Value(value = "server.port", type = ValueType.SYSTEM_PROPERTY, defaultValue = "8080")
    private Integer serverPort;

    @Value(value = "DATABASE_URL", type = ValueType.ENV_VAR, defaultValue = "jdbc:h2:mem:test")
    private Provider<String> databaseUrl;

    @Value(param = "MAX_CONNECTIONS", type = ValueType.SANKHYA_PARAM, defaultValue = "10")
    private Provider<Integer> maxConnections;

    @Transactional
    public void processar(@Valid PedidoDTO pedido) {
        String url = databaseUrl.get();
        int port = serverPort;
        int pool = maxConnections.get();
        // ...
    }
}
```

### Feature flags (lazy + `SANKHYA_PARAM`)

```java
@Service(serviceName = "PedidoServiceSP")
public class PedidoService {

    @Value(param = "VALIDACAO_AVANCADA_ATIVA", type = ValueType.SANKHYA_PARAM, defaultValue = "false")
    private Provider<Boolean> validacaoAvancadaAtiva;

    @Value(param = "NOVO_CALCULO_IMPOSTO", type = ValueType.SANKHYA_PARAM, defaultValue = "false")
    private Provider<Boolean> novoCalculoImposto;

    private final ValidadorAvancado validadorAvancado;
    private final CalculadoraImpostoV2 calculadoraV2;

    @Inject
    public PedidoService(ValidadorAvancado validadorAvancado, CalculadoraImpostoV2 calculadoraV2) {
        this.validadorAvancado = validadorAvancado;
        this.calculadoraV2 = calculadoraV2;
    }

    @Transactional
    public void processar(@Valid PedidoDTO pedido) {
        if (validacaoAvancadaAtiva.get()) {
            validadorAvancado.validar(pedido);
        }
        if (novoCalculoImposto.get()) {
            calculadoraV2.calcular(pedido);
        }
    }
}
```

### Pool / credenciais (tudo lazy, resolve só ao conectar)

```java
@Component
public class DatabaseConfig {

    @Value(value = "DATABASE_URL", type = ValueType.ENV_VAR, defaultValue = "jdbc:h2:mem:test")
    private Provider<String> databaseUrl;

    @Value(value = "DB_USERNAME", type = ValueType.ENV_VAR, defaultValue = "sa")
    private Provider<String> username;

    @Value(value = "DB_PASSWORD", type = ValueType.ENV_VAR, defaultValue = "")
    private Provider<String> password;

    @Value(param = "MAX_POOL_SIZE", type = ValueType.SANKHYA_PARAM, defaultValue = "20")
    private Provider<Integer> maxPoolSize;

    public Connection conectar() throws SQLException {
        return DriverManager.getConnection(
            databaseUrl.get(),
            username.get(),
            password.get()
        );
    }
}
```

---

## Anti-patterns (não gerar)

| Não | Sim |
| --- | --- |
| `private final String APP_NAME` com `@Value` | campo não-final |
| `@Value` em classe sem estereótipo | `@Component` / `@Service` |
| `MGECoreParameter.getParameter("X")` | `@Value(param = "X", type = SANKHYA_PARAM, ...)` |
| `private String serverPort` + parse | `private Integer serverPort` |
| JSON gigante num único default | vários `@Value` simples |
| `defaultValue = ""` como se fosse “sem fallback” | default utilizável de verdade |
| esperar que `Provider.get()` releia o Om a cada chamada | cache por instância |

Campo `null`: classe não gerenciada pelo Guice, tipo não suportado, ou `@Value` em constante.

DI de componentes: [dependency-injection.md](dependency-injection.md).
