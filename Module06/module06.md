- [English](module06.md)
- [Português](module06.pt.md)

# Storage services and CDN

## Storages:

### S3

- Amazon S3 - Simple Storage Service
  - where we store objects (images, backups, logs, etc);
- Security: encryption at rest and in transit;

  **You pay for:**
  - space used (GB/month);
  - requests (http);
  - data transfer out of AWS environment; (within AWS many transfers are free)
  

  **Lifecycle:**
  - you can configure to automatically move objects between available storage types
    Example:
    - Standard: standard and fast storage;
    - Standard-IA (Infrequent Access): cheaper, but will charge if you access;
    - Glacier: long-term archival and can take minutes/hours to return the object;
    
    - Practical example: logs that are accessed daily for 30 days, after 90 days are moved to Glacier to reduce cost.

This is an example of S3 where all the static files of a website in production are:

![alt text](./images/bucketS3assets.png)

#### Glacier

Glacier is a low-cost storage option, designed for long-term retention and low-access data. Main points:

- Common use: old photos, scientific data, long-term backups, health records — everything that needs to be stored, but rarely accessed.
- Minimum retention and cost: Glacier Flexible Retrieval (former Glacier) has recommended minimum retention of ~90 days; Glacier Deep Archive has recommended minimum retention of ~180 days. There are charges for early deletion and recovery times vary according to class (from minutes to hours or days).
- Best practices: use lifecycle rules to automatically move objects between classes (Standard → Standard‑IA → Glacier → Deep Archive) and plan RTO/RPO considering recovery times.

**Quick concepts (input → service → output/description)**

| Input | Service | Output / Description |
|---|---|---|
| Lifecycle Policy | S3 | Rules to automatically move or delete objects between Storage Classes (e.g.: Standard → Glacier). |
| Cross-Region Replication | S3 | Replicates objects in another region for disaster recovery and lower regional latency. |
| Cache Behavior | CloudFront | Defines how CloudFront stores and serves content (TTL, headers, query strings, cookies). |
| Storage Class | S3 | Defines the storage type (Standard, Standard‑IA, One Zone‑IA, Glacier Flexible Retrieval, Deep Archive). |

### Amazon EBS (Elastic Block Store)
- **Block** storage — used as "HD/SSD" for EC2 instances.
- Each EBS volume can only be mounted on one EC2 at a time (except in special cases like EBS Multi-Attach).
- Volume types (optimized for cost, IOPS, throughput).
- Persistent: even if the EC2 instance is stopped, the volume continues storing data (until deleted).


![alt text](./images/ebsVolumes.png)

**Summary:**
- **S3 → objects** (files, scalable, cheap, with lifecycle).
- **EBS → blocks** (virtual disks for EC2, I/O performance).

---
#### Costs and business examples on AWS


- Effect of stopping, terminating and deleting instances and volumes:  
  - **Stop:** the instance is shut down, but the EBS volume remains and continues generating charges.  
  - **Terminate:** the instance is removed and, depending on configuration, the EBS volume may or may not be deleted.  
  - **Delete volumes:** when an EBS volume is removed, you stop being charged for it.



## CloudFront

For the *Cloud Practitioner* certification level, it's enough to understand what the service is and how it's used.

Edge Locations / Points of Presence (PoP) concepts were already seen in [module 01](../Module01/module01.md#como-entender-a-estrutura-da-nuvem).

<p align="center">
	<img src="./images/diagramCloudfront.png" alt="CloudFront and Edge Locations Diagram" />
</p>

> Note: the S3 static site endpoint uses HTTP; for HTTPS it's recommended to use CloudFront with an ACM certificate.

## Complementary reading

- [Amazon S3 - Developer Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/)
- [Amazon CloudFront - Developer Guide](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/)rage services and CDN

## Storages:

### S3

- Amazon S3 - Simple Storage Service
  - where we store objects (images, backups, logs, etc);
- Security: encryption at rest and in transit;

  **You pay for:**
  - space used (GB/month);
  - requests (http);
  - data transfer out of AWS environment; (within AWS many transfers are free)
  

  **Lifecycle:**
  - you can configure to automatically move objects between available storage types
    Example:
    - Standard: standard and fast storage;
    - Standard-IA (Infrequent Access): cheaper, but will charge if you access;
    - Glacier: long-term archival and can take minutes/hours to return the object;
    
    - Practical example: logs that are accessed daily for 30 days, after 90 days are moved to Glacier to reduce cost.

This is an example of S3 where all the static files of a website in production are:

![alt text](./images/bucketS3assets.png)

#### Glacier

Glacier is a low-cost storage option, designed for long-term retention and low-access data. Main points:

- Common use: old photos, scientific data, long-term backups, health records — everything that needs to be stored, but rarely accessed.
- Minimum retention and cost: Glacier Flexible Retrieval (former Glacier) has recommended minimum retention of ~90 days; Glacier Deep Archive has recommended minimum retention of ~180 days. There are charges for early deletion and recovery times vary according to class (from minutes to hours or days).
- Best practices: use lifecycle rules to automatically move objects between classes (Standard → Standard‑IA → Glacier → Deep Archive) and plan RTO/RPO considering recovery times.

**Quick concepts (input → service → output/description)**

| Input | Service | Output / Description |
|---|---|---|
| Lifecycle Policy | S3 | Rules to automatically move or delete objects between Storage Classes (e.g.: Standard → Glacier). |
| Cross-Region Replication | S3 | Replicates objects in another region for disaster recovery and lower regional latency. |
| Cache Behavior | CloudFront | Defines how CloudFront stores and serves content (TTL, headers, query strings, cookies). |
| Storage Class | S3 | Defines the storage type (Standard, Standard‑IA, One Zone‑IA, Glacier Flexible Retrieval, Deep Archive). |

### Amazon EBS (Elastic Block Store)
- Armazenamento em **blocos** — usado como “HD/SSD” das instâncias EC2.
- Cada volume EBS só pode ser montado em uma EC2 de cada vez (exceto em casos especiais como EBS Multi-Attach).
- Tipos de volume (otimizados para custo, IOPS, throughput).
- Persistente: mesmo que a instância EC2 seja parada, o volume continua armazenando os dados (até ser deletado).


![alt text](./images/ebsVolumes.png)

**Resumo:**
- **S3 → objetos** (arquivos, escalável, barato, com ciclo de vida).
- **EBS → blocos** (discos virtuais para EC2, performance de I/O).

---
#### Costs and business examples on AWS


- Effect of stopping, terminating and deleting instances and volumes:  
  - **Stop:** the instance is shut down, but the EBS volume remains and continues generating charges.  
  - **Terminate:** the instance is removed and, depending on configuration, the EBS volume may or may not be deleted.  
  - **Delete volumes:** when an EBS volume is removed, you stop being charged for it.



## CloudFront

For the *Cloud Practitioner* certification level, it's enough to understand what the service is and how it's used.

Edge Locations / Points of Presence (PoP) concepts were already seen in [module 01](../Module01/module01.md#como-entender-a-estrutura-da-nuvem).

<p align="center">
	<img src="./images/diagramCloudfront.png" alt="Diagrama CloudFront e Edge Locations" />
</p>

> Nota: o endpoint de site estático do S3 usa HTTP; para HTTPS é recomendado usar CloudFront com um certificado ACM.

## Leitura complementar

- [Amazon S3 - Developer Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/)
- [Amazon CloudFront - Developer Guide](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/)

