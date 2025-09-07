
# Redes na AWS

## Virtual Private Cloud - VPC

É uma rede isolada da internet dentro do cloud da AWS. O propósito de isolar recursos em uma VPC é garantir mais segurança, controle e organização. Assim, você evita que bancos de dados, servidores ou funções fiquem expostos diretamente na internet, reduzindo riscos e facilitando a gestão do ambiente.


### Exemplo de um caso de uso bem útil: VPC + OpenVPN

Por exemplo: se você criou e isolou os recursos dentro de uma VPC (Virtual Private Cloud), pode instalar um OpenVPN em uma EC2. Isso permite ter conexão direta e isolada com tudo que está dentro da VPC (RDS, Lambda, etc), sem expor esses recursos à internet. Ou seja, só quem estiver conectado via VPN consegue acessar esses serviços internos.



![alt text](/Module04/images/diagramEC2OpenVPN.png)

### Trade-off:

Em vez de configurar tudo manualmente, tem como utilizar uma AMI pronta com OpenVPN disponível no AWS Marketplace ou optar por um serviço de VPN oferecido pela própria Amazon. A escolha depende do propósito: para empresas, esse custo faz parte do negócio; já para fins didáticos — onde o orçamento é muito limitado — vale muito a pena implementar a solução manualmente para aprender e compreender a complexidade do isolamento de rede em uma VPC.


---
##  Subnets: são as redes onde você coloca os serviços. Podem ser privadas ou públicas.




- Security Groups (SG): funciona como um gateway. Ele decide quem pode acessar o recurso ou não;
- Route 53: resolve o DNS para conectar internamente;
- CloudFront:
- Elastic Load Balancer: poderoso e muito utilizado.

