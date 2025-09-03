
# Santander - CodeGirls2025 - AWS-Essentials


> **Propósito repositório:** documenta brevemente o conteúdo abordado durante o bootcamp **Santander Code Girls - 2025**, oferecido pela plataforma [Dio.me](https://www.dio.me/en), e destaca as implicações do uso das ferramentas na AWS - Amazon Web Services. Não tem o propósito de ser um tutorial. Para instruções detalhadas e sempre atualizadas, recomendo consultar a [documentação oficial da AWS](https://docs.aws.amazon.com/).

> **Nível:** Este bootcamp é introdutório e cobre conceitos básicos de computação em nuvem, equivalentes ao conteúdo exigido para a certificação **AWS Certified Cloud Practitioner CLF-02 AWS** .

---
## Como entender a estrutura da nuvem? 

Antes da AWS, manter um sistema em produção exigia:

- Investimento em servidores físicos, energia e espaço;
- Equipe especializada para manutenção;
- Custos fixos, mesmo sem uso total;
- Escalabilidade limitada (dependia de novos equipamentos).


A ideia de nuvem é abstrata, mas contruída fisicamente por meio de datacenters físicos espalhados pelo mundo e agregados por regiões. Para exemplificar, peguemos a América do Sul:

- **Region:** América do Sul.
- **Availability Zone - AZs:** são usadas para hospedar recursos computacionais(EC2, banco de dados, etc) e garantir disponibilidade e redundância. Existem 3;
    * Nota: 1 AZ tem provavelmente 2 ou mais datacenters conectados.

- **Edge location:**  datacenters menores que são usados para **replicar conteúdo** e **reduzir latência** fornecendo dados mais rapidamente para os clientes através do serviço **Amazon CloudFront** (Content Delivery Network – CDN) por exemplo.   Tanto as Edge Locations quanto as AZs fazem parte da infraestrutura global da AWS, mas as Edge Locations são especialmente acessíveis para empresas que desejam entregar conteúdo (como streaming) de forma eficiente em regiões como a América do Sul, mesmo que o processamento principal esteja em outra região.

    Para saber mais consulte a [Infraestrutura global da AWS](https://aws.amazon.com/about-aws/global-infrastructure/)


Hoje, o que a AWS oferece é a infraestrutura física e global em segundos, e você apenas utiliza os serviços. Aqui já esbarramos em um conceito muito importante e inicial sobre a AWS: a separação de responsabilidade entre a AWS e o cliente.

## **Modelo de responsabilidade compartilhada:**

- **“Security of the Cloud”:** AWS é responável pela segurança **DA** estrutura física (datacenters, hardware, redes).
- **“Security in the Cloud”:** cliente é responsável pela segurança **DENTRO** da nuvem. Isso inclui, proteger as credenciais de acesso, manter sistemas operacionais e softwares atualizados e manter boas práticas no uso dos serviços. Se houver um vazamento de senha ou uma falha por falta de atualização, a responsabilidade do cliente.


## **Modelos de Serviço em Nuvem: IaaS, PaaS e SaaS**

Na AWS (e em outras nuvens), existem diferentes modelos de serviço:

- **IaaS (Infrastructure as a Service):** você gerencia servidores, armazenamento e redes, enquanto a AWS cuida da infraestrutura física. Ex: EC2;
- **PaaS (Platform as a Service):** você gerencia apenas as aplicações, enquanto a AWS gerencia o sistema operacional, middleware e infraestrutura. Ex: Lambda
- **SaaS (Software as a Service):** você apenas usa o software, sem se preocupar com infraestrutura ou plataforma. Ex: qualquer serviço onde você só faz a conta e usa; Netflix, Gmail, GitHub;

Cada modelo apresenta um grau distinto de responsabilidade entre o cliente e a AWS. Mais detalhes de como essas responsabilidades se distribuem em cada modelo, consulte o [Modelo de Responsabilidade Compartilhada](https://docs.aws.amazon.com/prescriptive-guidance/latest/strategy-accelerating-security-maturity/understanding-the-security-scope.html).



## Primeiros passos na plataforma AWS:

### 1. Login e Segurança (IAM)

- Evitar uso da conta root no dia a dia;
- Criar usuários com menor privilégio e organizá-los em grupos;
- Gerenciar permissões via políticas (JSON) — podem ser AWS Managed ou Custom;
- Ativar MFA (camada extra de segurança).

### 2. AWS Management Console, AWS CLI e CloudShell
- **Console:**  acessada pelo navegador. Intuitiva, ideal para iniciantes ou tarefas específicas.  
- **CLI (Command Line Interface):** interface em linha de comando, ideal para automação, scripts e maior controle dos serviços. Requer configuração inicial de credenciais, mas é o mais usado em desenvolvimento.

**Exemplos básicos (AWS CLI):**

```bash
# Configurar credenciais - me permite interagir com os endpoints públicos sa AWS
aws configure

# Listar buckets S3
aws s3 ls

# Descrever instâncias EC2
aws ec2 describe-instances


- **CloudShell**: ambiente dentro da AWS. Não consigo rodar os scripts locais, por exemplo, mas consigo visualizar informações da conta e serviços. 


### 3. Amazon EC2 – Computação em Nuvem com VM
- o que é, AMI, criação via CLI e Console
- SSH access e keypair para isso
- como instalar pacotes dentro (ex: openVPN)
- também falar que já tem uma AMI pronta com o openVPN, etc
- Limitar a exemplificar, cuidar para não sair muito do escopo

### 4. Storages
- S3 (falar do lifecycle)
- EBS (volumes)

---
### 5. Falar sobre custos e alguns exemplos de negócio aws

- Como o uso de recursos influencia na cobrança (on-demand, reservado, etc)
- Efeito de parar, encerrar e deletar instances and volumes;
- Casos de uso reais: OpneVPN(posso usar um diagrama do meu openVPN implementado na migraçao)





