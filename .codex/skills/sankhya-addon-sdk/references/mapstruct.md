# MapStruct

Doc: https://developer.sankhya.com.br/docs/%EF%B8%8Fmapeamento-de-objetos-com-mapstruct

O processador do Studio ativa MapStruct se a lib estiver no classpath.

```groovy
dependencies {
    implementation 'org.mapstruct:mapstruct:1.5.5.Final'
    annotationProcessor 'org.mapstruct:mapstruct-processor:1.5.5.Final'
}

tasks.withType(JavaCompile) {
    options.compilerArgs += [
        '-Amapstruct.defaultComponentModel=cdi',
        '-Amapstruct.unmappedTargetPolicy=IGNORE'
    ]
}
```

Kotlin/KSP: **sem suporte** oficial.

```java
@Mapper(componentModel = "cdi")
public interface UserMapper {
    @Mapping(source = "nomeUsuario", target = "username")
    UserDTO toDTO(UserJapeEntity entity);

    @Mapping(target = "nomeUsuario", source = "username")
    UserJapeEntity toEntity(UserDTO dto);

    List<UserDTO> toDTOList(List<UserJapeEntity> entities);
}
```

Injete o mapper no controller/`@Component` com `@Inject`. Sem `Mappers.getMapper` em código gerenciado.

Se `UnsatisfiedDependencyException`: `componentModel = "cdi"`, processor em `annotationProcessor`, `./gradlew clean build`.

Caminho padrão: Request DTO → entidade `@JapeEntity` → Response DTO. Não crie um terceiro modelo de domínio por default.
