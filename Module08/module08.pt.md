# Gerenciamento e governança AWS

## CloudWatch 

Gera métricas, logs e dashboards para monitoramento operacional de recursos e aplicações (CPU, latência, erros, etc.).
Principais usos: coleta de métricas customizadas, centralização de logs (CloudWatch Logs), criação de alarmes (SNS/ações) e dashboards operacionais.
Boas práticas: instrumentar apenas métricas necessárias, configurar retenção de logs apropriada, evitar alertas ruidosos e integrar com alarmes/auto-scaling.

## CloudTrail

Registra chamadas de API e eventos de gerenciamento e dados (opcional) — quem fez o quê, quando e de onde. Usado para auditoria, investigação de incidentes e conformidade.
Boas práticas: habilitar um trail multi-região enviando logs para um bucket S3 centralizado (com versionamento e políticas rígidas), proteger o bucket (encryption, bloqueio de deleção), habilitar CloudTrail Insights para anomalias e registrar data events críticos (S3/Lambda) apenas quando necessário devido ao custo/volume.

## CloudFormation

- Ferramenta de Infra-as-Code da AWS para criar, atualizar e deletar recursos de forma declarativa (YAML/JSON).
- Ideal para automação, padronização e versionamento de infra em ambientes de desenvolvimento e produção.

## Identity and Access Management - IAM

IAM  controla quem pode acessar recursos AWS e com quais permissões (usuários, grupos, roles, policies).

- Principais conceitos:  policies JSON, users, groups, roles (assume role para serviços/identidades externas), políticas gerenciadas e inline.
- Boas práticas: aplicar princípio do menor privilégio, usar roles em vez de chaves longas, habilitar MFA, rotacionar credenciais e centralizar gestão com AWS Organizations/SCPs quando aplicável.

## Policies e Roles

- Policies: são documentos JSON que definem permissões para ações em recursos; podem ser gerenciadas ou inline e aplicadas a usuários, grupos ou roles.
- Roles: identidades assumíveis por serviços ou usuários externos para obter permissões temporárias - a role oferece tokens - (preferir roles para segurança e menos uso de chaves estáticas).


![alt text](./images/policiesandRoles.png)


## Links oficiais

- [IAM (visão geral)](https://docs.aws.amazon.com/iam/)
- [Policies e JSON policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)
- [Roles e AssumeRole](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)
- [Boas práticas de IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)