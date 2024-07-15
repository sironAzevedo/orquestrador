### Sobre a aplicação
A aplicação "Orchestrator" será construída utilizando Java 17 e Spring Boot. O objetivo principal é criar um orquestrador agnóstico que possa interagir com diversos produtos sem conhecê-los previamente. A comunicação com esses produtos será feita de forma dinâmica, baseada em parâmetros recebidos em runtime.

### Requisitos
#### Requisitos Gerais:  
1. Agnosticidade: A aplicação não deverá conhecer os produtos a serem orquestrados e terá apenas um endpoint que aceitará qualquer path.
2. Endpoint Genérico: A aplicação deverá ter um endpoint genérico que receberá as seguintes informações via parâmetro:
   * nome do produto a ser chamado
   * token de autorização
   * correlation-id  
   * número da conta corrente
#### Requisitos de Integração
3. Parameter Store: A aplicação deverá buscar as seguintes informações do AWS Parameter Store com base na URI do produto recebida via parâmetro:
   * timeout
   * uri do produto
4. WebClient: Realizar a chamada ao produto para buscar a informação solicitada utilizando o WebClient.
5. Kafka: Ao finalizar, enviar a informação aos tópicos Kafka kafka-Topico orch e kafka-Topico produto de forma assíncrona.

### Documentation

O projet contém as seguintes tecnologia:
* Spring Boot 3.3.1
* Java 17
* Maven
* Docker
* Kafka
* SQS
* [Wiremock](https://wiremock.org/)
* Lombok
* Unit tests com Junit e Mockito

URL swagger local:
```
http://localhost:8080/swagger-ui/index.html#/
```

### Executando a aplicação:
Sólicito executar o arquivo docker-compose presente no projeto dentro da pasta docker, pois a aplicação se conecta ao kafka para produzir e consumir mensagens para executaro fluxo de formalização.

* #### Docker-compose:
```
Comando: docker-compose up -d --build
```


#### Kafka:
Após a execução do docker-compose o mesmo fará o pull das imagens zookeeper, kafka e kafdrop

* Criando tópico no kafka:
  * Como sugestão, utilizar o kafdrop para a criação do seguintes topic:
  * Obs: Para acessar o kafdrop url: http://localhost:19000/
  * Topic:
    * transaction-nacional-topic
    * transaction-internacional-topic
    * motor-qualidade-topic