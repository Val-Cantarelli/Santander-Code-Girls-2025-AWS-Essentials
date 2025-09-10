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

## 