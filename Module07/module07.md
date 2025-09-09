# Recursos avançados e intermediários da AWS


## AWS Lambda

- Serviço de computação serverless: você só escreve o código da função, sem se preocupar com servidores.
- Executa funções sob demanda, em resposta a eventos (triggers).
- Ainda tem servidor, mas a AWS é quem gerencia.
- Outros serviços serverless: API Gateway, S3, DynamoDB, Cognito, SNS, SQS, Aurora Serverless.
- EC2 (servidor virtual, escala manual ou gerenciada) x Lambda (stand by, escala automática, cobrado por requisição).

### Exemplos de uso

- Processamento de arquivos enviados para um bucket S3 (ex: só rodar se for `.csv`).
- Automatização de tarefas, integração entre serviços, APIs sem servidor.

### Triggers (gatilhos)

- Lambda pode ser disparado por eventos do S3, DynamoDB, API Gateway, CloudWatch, etc.
- Exemplo: Upload de um arquivo `.csv` no S3 → dispara a função Lambda para processar o arquivo.

### Exemplo prático (Hello World com filtro CSV)

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






### Observações

- Lambda: cobrada por número de invocações e pela duração (medida em GB‑seconds); há custo adicional para provisioned concurrency.
- Tempo máximo de execução de uma função Lambda: 15 minutos.
- Permite escalabilidade automática.
- Cold start: depende do runtime, do tamanho do pacote e das dependências; provisioned concurrency reduz esse efeito.

## ECS e EKS

>Microservices: arquitetura que fragmenta uma aplicação em serviços pequenos e independentes — cada um com responsabilidade única, deployment próprio, possivelmente seu próprio armazenamento, e comunicação via APIs ou eventos; isso permite updates e escalabilidade isolada e reduz o impacto de deploys no restante do sistema.

![alt text](./images/monolithivsMicroService.png)

### Elastic Container Service (ECS) e Elastic Kubernetes Service (EKS)

Orquestram containers na nuvem — de forma análoga ao EC2, que orquestra VMs. O Amazon ECS é uma solução de orquestração integrada à AWS; o Amazon EKS é a oferta gerenciada de Kubernetes (projeto open‑source).

### ECS

Como é feita a orquestração?
- automatizar gerenciamento de clusters de containers que estão na Ec2 ou Fargate(serverless);
- escalar;
- integrar com outros serviços, seguranca nos acessos dos containers;

>O que são containers? Em um arquivo chamado Dockerfile escrevemos a "receita" do que vai ser a imagem: origem da imagem(site de onde é pega a imagem), dependências e comandos. Ao buildar o Dockerfile gera‑se uma imagem; ao rodar essa imagem com o Docker temos um container (instância em execução).

#### Imagem x Container

Diferente de VMs, os containers não trazem um sistema operacional completo na imagem: eles compartilham o kernel da máquina host, por isso são leves e iniciam rapidamente.

 - Imagem vs container: a imagem é o template imutável (build); o container é a instância em execução dessa imagem.
 - Isolamento: containers isolam processos, redes e sistemas de arquivos usando namespaces e cgroups; eles compartilham o kernel do host (não virtualizam hardware), por isso são mais leves que VMs.
## SNS e SQS

### SNS — Simple Notification Service (assíncrono)

- Serviço de publisher/subscriber para envio de mensagens (push) a múltiplos destinos.
- Casos de uso: alertas/monitoramento, fan‑out entre microserviços, notificações móveis, integração entre sistemas.
- Endpoints suportados: Lambda, SQS, HTTP/HTTPS, email, SMS, mobile push.
- Fan‑out: publica uma mensagem em um tópico; SNS entrega para todos os assinantes do tópico (por exemplo, várias filas SQS ou funções Lambda).
- Filtragem de mensagens: é possível definir políticas de filtro por atributos para que assinantes recebam apenas mensagens relevantes.
- Entrega e durabilidade: retries configuráveis, integração com DLQs via SQS; mensagens podem ser criptografadas com KMS.
- Segurança: controle por IAM e políticas de tópico; confirmação/validação para endpoints HTTP(S).
- Diferença principal para SQS: SNS é push/pub‑sub (multiponto); SQS é fila pull (consumo individual, ordenação/TTL/visibilidade).

O Standard é o mais utilizado; o FIFO é recomendado quando a ordem das mensagens e deduplicação são cruciais (ex.: operações financeiras).

![alt text](./images/typesSNS.png)

### SQS — Simple Queue Service (fila)

Também é um sistema de entrega de mensagens, mas baseado em filas (pull):

- SQS = fila pull, feito para comunicação organizada e resiliente entre serviços. Produtor coloca a mensagem na fila; consumidores fazem polling e processam no próprio ritmo.
- Suporta visibilidade, retries, DLQ e retenção até o processamento.

Exemplo prático:

- Notificação imediata ao usuário: SNS → email/SMS/Lambda (push).
- Processamento assíncrono por workers: produtor envia para SQS → vários workers fazem pull e processam (desacoplamento, tolerância a falhas).
- Combinação comum: SNS publica um evento e entrega a várias SQS (fan‑out) para que cada serviço consuma de forma independente e organizada.

Observações rápidas:

- SNS tende a entregar imediatamente; SQS garante que a mensagem fique persistida até o consumo.
- Trate idempotência porque ambos podem entregar duplicatas (use FIFO se precisar de ordem/sem duplicatas).
- Combinação comum: SNS publica um evento e entrega a várias SQS (fan‑out) para que cada serviço consuma de forma independente e organizada.

Observações rápidas:

- SNS tende a entregar imediatamente, SQS garante que a mensagem fique persistida até o consumo.
- Trate idempotência porque ambos podem entregar duplicatas (use FIFO se precisar de ordem/sem duplicatas).


## Step Functions

Step Functions é o serviço da AWS para orquestrar fluxos de trabalho (state machines) entre serviços serverless e microserviços, oferecendo visibilidade, retries e tratamento de erros de forma declarativa.

### O que é

- Serviço de orquestração baseado em máquinas de estado (state machines).
- Permite definir passos (Task), condicionais (Choice), paralelismo (Parallel), mapeamento de coleções (Map), esperas (Wait) e estados finais (Succeed / Fail).

### Principais recursos

- Estados reutilizáveis: Task, Choice, Parallel, Wait, Map, Succeed, Fail, Pass.
- Resiliência: retries e catch por estado, timeouts e tratamento de erros integrado.
- Observabilidade: histórico de execução visual no console e integração com CloudWatch Logs/Metrics.
- Integrações diretas: Lambda, ECS, Batch, SNS, SQS, API Gateway e mais (reduz código glue).
- Tipos de execução: Standard (durável, histórico completo) e Express (alto throughput, custo otimizado para execuções curtas).

### Quando usar

- Orquestrar processos multi‑etapa (por exemplo: pagamento → estoque → notificação).
- Substituir scripts ou coordenação ad‑hoc entre serviços.
- Pipelines de dados, workflows de negócios e tarefas que precisam de retries e visibilidade.

### Exemplo passo a passo

1. order.created (evento)
2. validar pedido — Task (Lambda)
3. processar pagamento — Task (serviço externo ou Lambda) com retries
4. confirmar estoque — Parallel (checar múltiplos centros)
5. enviar confirmação ao cliente — Task (SNS ou Lambda)
6. Succeed (ou Catch → fluxo de compensação)

Dica: modele estados pequenos e idempotentes; use retries e catches para tornar o workflow tolerante a falhas temporárias.

### Observações

- Custo: Standard cobra por state transitions; Express cobra por duração/throughput — escolha conforme padrão de uso.
- Teste local: use SAM CLI ou Step Functions Local para testar antes do deploy.
