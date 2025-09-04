
# EC2 - Elastic Compute Cloud

O **EC2(Elastic Compute Cloud)** é o serviço de máquinas virtuais da AWS, similar ao VirtualBox, mas escalável e gerenciado na nuvem.

## Conceitos principais:
- **AMI (Amazon Machine Image):** imagem usada para inicializar a instância (Sistemas operacionais + configs). 
    * **Imagem:** é um arquivo binário que representa tudo o que está armazenado no volume de uma máquina virtual, incluindo o sistema operacional e suas configurações. Se você quiser replicar uma instância EC2, basta criar ou usar a imagem (AMI) dela — através disso garante que todas as configurações e o ambiente sejam copiados na nova instância.
- **Tipo da instância:** define recursos de CPU/memória;
- **Security Group:** firewall virtual que controla tráfego - você usa ou cria um conforme a necessidade; 
- **Key Pair:** chave usada para acessar a instância via SSH.
        
  > **Atenção**: não é possível associar uma nova key pair após a criação da instância.

E esses conceitos é que fazem uma instãncia de EC2: CPU e memória da VM + imagem + groupos que vão definir o tráfego de entrada e saída + keypair para acesso via SSH depois.

![alt text](./images/ec2.png)

### Storages
- Amazon S3 - Simple Storage Service
  - onde guardamos objetos(imagens, backups, logs, etc);

  **É pago por:**
  - espaço utilizado(GB/mês);
  - requisições(http);
  - envio de dados para fora do ambiente da AWS;(dentro da AWS muitas tranferências são gratuitas)

  **Ciclo de vida:**
  - tem como configurar para mover os objetos automaticamente entre os tipos de armazenamento disponíveis
    Exemplo:
    - Standard: armazenanmento padrão e rápido;
    - Standard-IA(Infrequent Access): mais barato, mas vai cobrar se você acessar;
    - Glacier: arquivamento de longo prazo e pode levar entre minutos/horas para retornar o objeto;
    
    - Exemplo prático: logs que são acessados diariamente por 30 dias, depois de 90 dias são movidos pro Glacier para reduzir custo.

Esse é um exemplo de S3 onde estão todos os estáticos de um websoite em produção:

![alt text](./images/bucketS3assets.png)


#### Amazon EBS (Elastic Block Store)
- Armazenamento em **blocos** — usado como “HD/SSD” das instâncias EC2.
- Cada volume EBS só pode ser montado em uma EC2 de cada vez (exceto em casos especiais como EBS Multi-Attach).
- Tipos de volume (otimizados para custo, IOPS, throughput).
- Persistente: mesmo que a instância EC2 seja parada, o volume continua armazenando os dados (até ser deletado).


![alt text](./images/ebsVolumes.png)

**Resumo:**
- **S3 → objetos** (arquivos, escalável, barato, com ciclo de vida).
- **EBS → blocos** (discos virtuais para EC2, performance de I/O).

---
### Custos e exemplos de negócios na AWS

- O uso dos recursos influencia diretamente na cobrança:  
  - **On-demand:** você paga apenas pelo tempo de uso da instância, sem compromisso de longo prazo.  
  - **Reservado:** você se compromete com um período (ex: 1 ou 3 anos) e recebe desconto significativo.  
  - **Spot:** utiliza capacidade ociosa da AWS com preços reduzidos, mas pode ser interrompida a qualquer momento. 

- Efeito de parar, encerrar e deletar instâncias e volumes:  
  - **Parar (stop):** a instância é desligada, mas o volume EBS permanece e continua gerando cobrança.  
  - **Encerrar (terminate):** a instância é removida e, dependendo da configuração, o volume EBS pode ser deletado ou não.  
  - **Deletar volumes:** quando removido um volume EBS, você deixa de ser cobrado por ele.




