# orquestrador
A aplicação "Orchestrator" será construída utilizando Java 17 e Spring Boot. O objetivo principal é criar um orquestrador agnóstico que possa interagir com diversos produtos sem conhecê-los previamente. A comunicação com esses produtos será feita de forma dinâmica, baseada em parâmetros recebidos em runtime.


# Docker
Comando docker para executar o terraform localmente. Com esse comando não é necessario instalar o terraform na maquina:  
docker run -it -v $PWD:/app -w /app --entrypoint "" hashicorp/terraform:light sh  
OBS:  O $PWD é o path da pasta dos arquivos .tf

### Comandos:  
* terraform init -upgrade - Inicializar o projeto
* terraform validate
* terraform plan -out "nome do plano"
* terraform apply
* terraform destroy