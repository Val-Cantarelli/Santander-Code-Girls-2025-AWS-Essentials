## RDS

É o serviço de bancos de dados relacionais (relacionamento entre tabelas) da AWS.

<p align="center">
  <img src="./images/RDStypes.png" alt="Tipos de engines suportadas pelo Amazon RDS" />
</p>

- **Amazon Aurora:** Banco relacional compatível com MySQL e PostgreSQL, otimizado pela AWS. Alta performance e escalabilidade; indicado quando precisa de throughput maior que MySQL/Postgres gerenciados. Custo geralmente maior, mas oferece recursos avançados de replicação e recuperação.
- **Oracle:** Banco comercial maduro, recursos avançados (PL/SQL, particionamento, etc.). Bom para legado empresarial que já usa Oracle; custo de licença elevado.
- **Microsoft SQL Server:** Banco comercial com forte integração ao ecossistema Microsoft (.NET, SSIS, etc.). Uso comum em aplicações corporativas Windows; também tem custo de licença.
- **MySQL:** Open source, fácil de usar e amplamente suportado. Boa escolha para aplicações web tradicionais; menor custo operacional.
- **PostgreSQL:** Open source, foco em conformidade ACID e funcionalidades avançadas (JSONB, extensões). Excelente para consultas complexas e consistência.
- **MariaDB:** Fork do MySQL com diferenças/ajustes de compatibilidade. Alternativa ao MySQL dependendo da versão/comunidade.

Observações rápidas:
- A escolha da engine depende de compatibilidade, custo de licenciamento, funcionalidades e escala.
- Para novos projetos sem restrições, PostgreSQL ou MySQL são boas opções (Aurora se precisar de mais performance).
- RDS gerencia backups, patching e alta disponibilidade (Multi‑AZ), reduzindo esforço operacional.

### E por que não só colocar um servidor de banco de dados dentro e uma EC2? 
O RDS oferece o gerenciamento completo (backups automáticos, patching, replicas, monitoramento e escalabilidade). Caso contrário, seria preciso acessar a EC2 e configurar/operar tudo manualmente — o que fica ainda mais complexo se houver vários servidores ou engines diferentes.

## DynamoDB - NoSQL

É o serviço de banco de dados não relacional da AWS. É schema-less: você cria tabelas, mas os itens (registros) não precisam ter os mesmos atributos — isso facilita trabalhar com dados semiestruturados.

- Modos de capacidade:
  - **On-demand:** escala automaticamente sem necessidade de provisionar throughput (bom para cargas imprevisíveis);
  - **Provisioned:** você define capacidade de leitura/gravação (RCU/WCU) — útil para workloads estáveis e otimização de custos.
- **Global Tables:** replicação multi-região gerenciada para baixa latência global e recuperação de desastre.
- **TTL:** time-to-live para expiração automática de itens.
- **Streams:** fluxo de alterações (INSERT/UPDATE/REMOVE) para integração com Lambda, processamento de eventos e replicação customizada.
- **Transações:** suporte a transações ACID em múltiplas operações dentro do DynamoDB.
- **Índices:** GSI (Global Secondary Index) e LSI (Local Secondary Index) para consultas flexíveis.

Exemplo CLI (inserir item):

```bash
aws dynamodb put-item --table-name MinhaTabela --item '{"id":{"S":"123"},"nome":{"S":"teste"}}'
```

## Backup e recuperação de dados

- Guarda o que é crucial pra subir o sistema rapidamente no caso de ataque;
- RPO (Recovery Point Objective): quanto dado pode ser perdido sem danos críticos ao negócio.  
- RTO (Recovery Time Objective): quanto tempo o sistema pode ficar fora do ar.  
- Armazenamento e ferramentas: snapshots automáticos do RDS, Point-in-Time Recovery (PITR), AWS Backup para planos e retenção, e S3 para armazenar dumps/export.  
- Boas práticas: automatizar políticas de retenção, replicar snapshots entre regiões para DR, e testar restores regularmente.


Onde armazenar?

- S3;
- [AWS Backup](https://docs.aws.amazon.com/aws-backup/latest/devguide/):gerenciar e automatizar o backup;
