# AWS Lambda

- Serviço de computação serverless: você só escreve o código da função, sem se preocupar com servidores.
- Executa funções sob demanda, em resposta a eventos (triggers).
- Ainda tem servidor, mas a AWS é quem gerencia.
- Outros serviços serverless: API Gateway, S3, DynamoDB, Cognito, SNS, SQS, Aurora Serverless.
- EC2 (servidor virtual, escala manual ou gerenciada) x Lambda (stand by, escala automática, cobrado por requisição).

## Exemplos de uso

- Processamento de arquivos enviados para um bucket S3 (ex: só rodar se for `.csv`).
- Automatização de tarefas, integração entre serviços, APIs sem servidor.

## Triggers (gatilhos)

- Lambda pode ser disparado por eventos do S3, DynamoDB, API Gateway, CloudWatch, etc.
- Exemplo: Upload de um arquivo `.csv` no S3 → dispara a função Lambda para processar o arquivo.

## Exemplo prático (Hello World com filtro CSV)

```python
def lambda_handler(event, context):
    # Exemplo: só processa se o arquivo for .csv
    key = event['Records'][0]['s3']['object']['key']
    if key.endswith('.csv'):
        # processa o arquivo
        return {'status': 'CSV processed'}
    else:
        return {'status': 'Not a CSV'}
```

## Observações

- Lambda cobra por execução e tempo de processamento.
- Tempo máximo de requisição lamda: 15 minutos
- Permite escalabilidade automática.
- Cold start: dependendo do sistema que você tiver no Lambda uma inicializaçào demorada pode ser um problema.

