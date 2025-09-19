## Resumo do desafio Terraform — Lambda + API Gateway

1. Preparação do diretório
	- Código da função Lambda em `src/handler_function.py` (handler `handler`).
	- Arquivo principal do Terraform: `main.tf` (gera o zip, cria role, lambda e API).
    **Obs.: prefereri deixar tudo em um arquivo por se tratar de um demo.**

2. Autenticado AWS cli;    

3. Inicializar o Terraform
	- `terraform init` — baixa providers (`aws` e `archive`) e prepara o módulo.

4. Planejar e aplicar
	- `terraform plan` — revisa os recursos que serão criados.
	- `terraform apply` — cria os recursos na AWS (gera `lambda.zip` a partir de `src/` durante o processo).

5. Verificar o endpoint
	- `terraform output -raw api_endpoint` — recupera o endpoint HTTP criado.
	- Teste rápido: `curl $(terraform output -raw api_endpoint)` — retorna a resposta da Lambda.

6. Depois de demontrado o demo rodamos:
	- `terraform destroy` — e os recursos criados pela configuração são deletados da AWS.

---

### Resultado:

#### Lamda function criado na AWS:

![alt text](/Module10/images/AWSLambdaTF.png)

---

#### Retorna a menssagem quando chamado no endpoint:


![alt text](/Module10/images/browserTF.png)

---

### Fluxo Terraform:

1. O `data "archive_fle"` empacota a pasta `src/` em um `lambda.zip` quando o Terraform executa o plan/apply. Esse artefato tem o  `handler_function.py`.
2. O Terraform cria uma `aws_iam_role` com política mínima para permitir que a Lambda envie logs ao CloudWatch.(Você declara uma aws_iam_role no Terraform com as permissões mínimas - ou anexa AWSLambdaBasicExecutionRole; o runtime da Lambda então grava os logs no CloudWatch.)
3. Em seguida o recurso `aws_lambda_function` aponta para o `lambda.zip` gerado e usa `handler_function.handler` como entrypoint.
4. O `aws_apigatewayv2_api` (HTTP API) é criado e integrado à Lambda via `aws_apigatewayv2_integration` usando o `invoke_arn` da função.
5. Uma rota `GET /` é criada e o stage `$default` faz deploy automático (`auto_deploy = true`).
6. Então a `aws_lambda_permission` permite que o API Gateway invoque a função Lambda.

--- 

Esse desafio foi útil para ter uma experiência com Terraform - já que havíamos feito uma solução similar via CloudFront usando templates e porque reúne componentes comuns de infraestrutura serverless: empacotar código, configurar permissões, publicar função e depois expor via API.

Com Terraform você declara infraestrutura como código - IaC, o que facilita reprodutibilidade e versionamento.