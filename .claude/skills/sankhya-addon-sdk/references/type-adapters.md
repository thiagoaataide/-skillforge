# Adaptadores de tipos

Doc: https://developer.sankhya.com.br/docs/%EF%B8%8F-adaptadores-de-tipos

Use `@GlobalTypeAdapter` só quando o tipo **não** tem adapter nativo (ex.: `ZonedDateTime`). Precedência: global **sobrescreve** nativo.

```java
@GlobalTypeAdapter
public class ZonedDateTimeAdapter
        implements JsonSerializer<ZonedDateTime>, TypeAdapter<ZonedDateTime>, JsonDeserializer<ZonedDateTime> {

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ISO_OFFSET_DATE_TIME;

    @Override
    public ZonedDateTime fromVO(Object o) {
        if (o == null) return null;
        return ((Timestamp) o).toInstant().atZone(ZoneId.systemDefault());
    }

    @Override
    public Object toVO(ZonedDateTime value) {
        return value == null ? null : Timestamp.from(value.toInstant());
    }

    @Override
    public void setType(Class<? extends ZonedDateTime> type) {}

    @Override
    public ZonedDateTime deserialize(JsonElement json, Type type, JsonDeserializationContext ctx) {
        return ZonedDateTime.parse(json.getAsString(), FORMATTER);
    }

    @Override
    public JsonElement serialize(ZonedDateTime value, Type type, JsonSerializationContext ctx) {
        return new JsonPrimitive(FORMATTER.format(value));
    }
}
```

Nativos relevantes: `Boolean` ↔ `"S"`/`"N"`; `LocalDate`/`LocalDateTime` ↔ `Timestamp`; `Enum` ↔ `getValue()` ou `name()`; `BigDecimal` para números de banco.

Não reimplemente `BooleanAdapter`. Prefira `boolean`/`Boolean` na entidade e deixe o nativo gravar `S`/`N`.
