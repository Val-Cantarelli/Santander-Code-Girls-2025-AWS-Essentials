# Criando recursos na AWS

## Criando instância EC2

Pelo **Console**  ou via CLI:  

```bash
aws ec2 run-instances \
  --image-id ami-12345678 \
  --count 1 \
  --instance-type t2.micro \
  --key-name <my-key> \
  --security-groups <nome-do-SG>
````

### Acesso via SSH

- baixar o arquivo "my-key.pem" que foi criado em Keypair;
- atribui as permissões: chmod 400 my-key.pem;
- run: ssh -i my-key.pem ec2-user@ip-da-instancia


Na própria instância é possível ver as instruções para conexão:


![alt text](./images/connectViaSSH.png)

Se tudo der certo, provavelmente você terá o seguinte:

![alt text](<./images/ssh-ec2.png>)


## Desafio AWS: Criando um bucket S3 e hospedando um website estático

Nesse módulo, vimos como criar um bucket S3 via console da AWS, enviar os arquivos, alterar a política permitindo leitura pública dos objetos. 

Decidi então criar um [script](deploy_website_s3.sh) bash com AWS CLI e é possível ver o resultado neste endpoint: [DesafioAWS](http://dio-staticwebsite.s3-website-us-east-1.amazonaws.com/).

> **Atenção:** O endpoint acima utiliza HTTP (não HTTPS). Navegadores modernos podem exibir avisos de segurança ao acessar o site, especialmente em modo anônimo/incógnito ou em dispositivos móveis.  
> Para HTTPS, seria necessário configurar certificado SSL - não é o escopo da aula agora.

# O que é AWS Lambda?

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

