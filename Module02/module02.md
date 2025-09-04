
# EC2 - Elastic Compute Cloud

O **EC2(Elastic Compute Cloud)** é o serviço de máquinas virtuais da AWS, similar ao VirtualBox, mas escalável e gerenciado na nuvem.

## Conceitos principais:
- **AMI (Amazon Machine Image):** imagem usada para inicializar a instância (Sistemas operacionais + configs). 
- **Tipo da instância:** define recursos de CPU/memória 
- **Security Group:** firewall virtual que controla tráfego.  
- **Key Pair:** chave usada para acessar a instância via SSH.
        
        !Atenção: não é possível associar uma nova key pair após a criação da instância.

## Criando instância

Pelo **Console** ou via CLI:  

```bash
aws ec2 run-instances \
  --image-id ami-12345678 \
  --count 1 \
  --instance-type t2.micro \
  --key-name <my-key> \
  --security-groups <nome-do-SG>
````

## Acesso via SSH

- baixar o arquivo "my-key.pem";
- atribuir as permissões: chmod 400 minha-chave.pem;
- run: ssh -i mmy-key.pem ec2-user@ip-da-instancia


Na própria instância é possível ver as instruções para conexão:

![alt text](image.png)



Se tudo der certo, provavelmente você terá o seguinte:

![alt text](<Screenshot 2025-09-03 at 9.02.06 PM.png>)




# Caso de uso: VPC + OpenVPN

Caso você tenha criado e islado os recursos dentro de uma VPC - Virtual Private Cloud, você pode instalar um openVPN dentro da EC2 que te permite ter conexão direta e isolada com tudo que está dentro da VPC.
* É possível também usar uma imagem - AMI - já pronta no Marketplace da AWS e evitar essa configuraçao, mas vale muito a pena para aprender e entender a complexidade do isolamento de rede de uma VPC.



### 4. Storages
- S3 (falar do lifecycle)
- EBS (volumes)

---
### 5. Falar sobre custos e alguns exemplos de negócio aws

- Como o uso de recursos influencia na cobrança (on-demand, reservado, etc)
- Efeito de parar, encerrar e deletar instances and volumes;
- Casos de uso reais: OpneVPN(posso usar um diagrama do meu openVPN implementado na migraçao)

