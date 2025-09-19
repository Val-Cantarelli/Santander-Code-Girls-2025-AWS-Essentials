#  S3 -> Lambda -> DynamoDB
#  API Gateway -> Lambda -> DynamoDB

Iremos trabalhar com um template YAML para o CloudFormation e duas funções Lambdas - uma interna e outra exposta via API Gateway que irá buscar o conteúdo gravado no DB e retornar à URL;


## O sistema é dividido em duas partes:
   
    - **Parte 1:**
        - um arquivo vai ser enviado ao S3;
        - S3 vai agir como trigger da Lambda `s3Processor`;
        - a Lambda `s3Processor` lê o conteúdo e persiste no DynamoDB;
    - **Parte 2:**
        - a Lambda `apiGetItem`, via solicitação de um cliente,  consulta o DynamoDB e retorna um JSON que vai ser exposto via API Gateway via GET/items;

## Como o deploy foi feito:

1. via AWS CLI:

```bash
aws cloudformation deploy \
    --template-file Module11/desafio/cloudformation/template.yaml \
    --stack-name codegirls-stack \
    --profile mfa-profile \
    --capabilities CAPABILITY_IAM
```


