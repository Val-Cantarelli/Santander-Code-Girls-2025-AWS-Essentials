# Desenvolvimento e ferramentas

## SDK e AWS CLI

### SDK
São bibliotecas diferentes de acordo com a linguagem de programação. É uma das formas de acessar recursos AWS integrando com os comandos no code.

#### Exemplo de uso do SDK com Python:

**Exemplo de uso do boto3 para recuperar credenciais do AWS Secrets Manager durante a execução (lambda_handler).**

```python
(...)
def get_db_credentials(secret_name: str, region_name="us-east-1"):
    client = boto3.client('secretsmanager', region_name=region_name)
    try:
        logger.info(f"Fetching secret: {secret_name}")
        get_secret_value_response = client.get_secret_value(SecretId=secret_name)
        if 'SecretString' in get_secret_value_response:
            secret = json.loads(get_secret_value_response['SecretString'])
            logger.info(f"Secret fetched successfully: {secret_name}")
        else:
            logger.warning("SecretBinary found, but it's not supported in this case.")
            secret = json.loads(get_secret_value_response['SecretBinary'])
        return secret
    except Exception:
        logger.exception(f"Error accessing secret: {secret_name}")
        raise
```

### AWS CLI

É outra forma de acessar AWS, mas integrada com a sua máquina. É muito útil pra rodar scritpt por exemplo, já que o CloudShell não permite pois é uma ferramenta internad do console AWS. Basta atualizar, configurar as chaves - que são criadas no usuário - e isso vai permitir rodar comandos diretos na aws.

![alt text](./images/CLIxSDK.png)

## CloudFormation

Já havíamos visto sobre CloudFormation no Módulo 8 e onde optei por criar uma stack via template para a criação de uma lambda function que retornava uma mensagem quando chamada.[Ver desafio](/Module08/desafioCloudFormation.md)

Como a aula traçou um comparativo com o Terraform, resolvi usá-lo para esse desafio do Modulo 10. [Ver desafio](./desafio/desafioTerraform.md)


## CodeDeploy


O AWS CodeDeploy é um serviço que automatiza a entrega de novas versões de um aplicativo para servidores, containers ou funções (Lambda), de forma segura e repetível; ele cuida de copiar os arquivos, rodar os passos necessários antes e depois da instalação, e permite trocar para a nova versão com pouco ou nenhum tempo de parada, além de ajudar a voltar à versão anterior se algo der errado.

- Serviço gerenciado para automatizar implantações de aplicações em instâncias EC2/on‑premises, AWS Lambda e Amazon ECS.
- Suporta modos de implantação in‑place (atualiza a instância existente) e blue/green (cria novo ambiente e faz o cutover para reduzir downtime).
- Conceitos-chave: aplicação, grupo de implantação e revision (artefato a ser implantado); permite políticas de rollout (percentual por vez, alarmes, etc.).
- Lifecycle hooks: scripts ou ações para executar antes/depois das etapas de instalação, validação e limpeza.
- Integração com CI/CD (CodePipeline, Jenkins, GitHub Actions) e monitoramento para habilitar rollback automático em falhas.
- Benefícios: implantações reproduzíveis, rastreáveis, com menor downtime e possibilidade de rollback controlado.



