- [English](module04.md)
- [Português](module04.pt.md)

# AWS Networking

## Virtual Private Cloud - VPC

It is an isolated virtual network within the AWS cloud. When creating it, you choose an IP address range (CIDR block). The purpose of isolating resources in a VPC is to ensure more security, control and organization. If you think at the enterprise level, many services, sectors...it's interesting to maintain this control and organization between services.

>Complementary reading: [VPC User Guide](https://docs.aws.amazon.com/vpc/latest/userguide/)

## Subnets

They are logical divisions of the VPC that determine the **location** and what **level of internet exposure** (public or private): 

***What does this logical division mean?***

*A subnet is a slice of the VPC's IP range (CIDR) — that is, you divide the VPC into smaller address blocks. Each subnet exists in a single Availability Zone and serves to group resources with the same purpose or exposure level. This division is logical (not physical): you choose which IPs belong to each subnet and associate route tables and rules that determine whether resources in that subnet can access the internet directly (via Internet Gateway) or only through NAT.*

- **Private subnet**: only private IPs, therefore not directly accessible from the internet. For external access (e.g.: updates), a NAT Gateway or NAT Instance is configured (which only allows outbound traffic).

- **Public subnet**: Allows resources to have public IP (ephemeral or via Elastic IP) and, therefore, be accessible from the internet, as long as there is an associated Internet Gateway (inbound and outbound traffic) and configured routes.

>**Note:** What defines whether a subnet is public or private is the presence (or absence) of a route to the internet through an Internet Gateway in the route table associated with it.

Usage examples:

1. A database (like RDS) is usually placed in a private subnet, so it's not directly accessible from the internet. Even if it needs to connect to the internet (e.g.: for updates), this can be done through a NAT Gateway.

2. A web server (like an EC2 instance running a website) is normally in a public subnet, with a public IP and access via Internet Gateway, allowing users to access the site from outside AWS, from anywhere on the internet.

![alt text](/Module04/images/amazonSubnet.png)


## Security Groups (SG)

A **Security Group** functions as a **virtual firewall**, which controls inbound and outbound traffic for resources in a VPC, such as EC2 instances, databases, among others.

### Main characteristics:
- Associated with a specific resource (e.g.: an EC2 instance);
- Allows rules based on:
  - Protocol (TCP, UDP, ICMP...)
  - Port (e.g.: 22, 80, 443)
  - Source or destination (e.g.: an IP, a CIDR range, another SG)

Example: allow SSH (port 22) only from your local IP.

>Complementary reading: [Security Groups & NACLs](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Security.html)

## Route 53: 

- Route 53 is AWS's DNS service: resolves names (e.g.: example.com) to IP addresses or to other AWS resources.
- Hosted zones:
  - **Public Hosted Zone:** public DNS, used to expose sites and services to the Internet.
  - **Private Hosted Zone:** private DNS, associated with one or more VPCs, used to resolve names internally (e.g.: `db.internal.company` pointing to the RDS endpoint).
- Basic records:
  - **A / AAAA:** point to an IP address.
  - **CNAME:** point to another name (not allowed at domain root).
  - **Alias:** special AWS feature that allows pointing directly to CloudFront, ELB, S3 static website, etc. (recommended for AWS resources).
- Routing policies (useful for high availability and testing):
  - **Simple:** single response.
  - **Weighted:** divides traffic between endpoints (useful for canary deploys).
  - **Latency:** directs to the region with lowest latency for the user.
  - **Failover:** uses health check to direct traffic only to healthy endpoints.
  - **Geolocation / Geo-proximity:** routes by geographic location.
- Health checks: Route 53 can monitor endpoints and use automatic failover if an endpoint becomes unavailable.
- Best practices:
  - Use **Alias records** to point to AWS resources (ELB, CloudFront, S3), avoids costs and TTL issues.
  - For internal services, prefer **Private Hosted Zones** associated with VPCs.
  - Configure appropriate TTLs according to failover/propagation needs.
- Practical example: use Route 53 + CloudFront to serve an S3 site with HTTPS (CloudFront provides certificate via ACM; Route 53 points with alias to distribution).

>[Route 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/)

## CloudFront:

For context about Edge Locations and AWS global infrastructure, see module 1: [Global infrastructure and Edge Locations](../Module01/module01.md).

Amazon CloudFront uses these Edge Locations (PoPs) to replicate and serve cached content close to users, reducing latency and load on the origin, better known as Content Delivery Network - CDN.

>[CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/)

## Elastic Load Balancer: 

It is an AWS service responsible for distributing load/managing traffic. It has four types:
1. Application Load Balancer: distributing based on rules: URLs, headers. 
    - Use case: applications that need WebSocket support (multiple open requests)

2. Network Load Balancer: manages at TCP/UDP network level, provides low latency;
    - Use case: financial services and games - high performance

3. Gateway Load Balancer: load balancing functions + network security (firewall and intrusion detection)
    - Use case: 

4. Classic Load Balancer: it's a LEGACY load balancer that distributes HTTP/HTTPS and TCP between EC2 instances.
    - Use case: applications developed before current ALBs and NLBs. Also for non-distributed architectures 


>[Elastic Load Balancing (ELB) - User Guide](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/)


## Extras:

### Attention: Authorization is different from connectivity! 

It's common to confuse **resource usage permissions** with **network access**. But they are different and complementary things:

| Aspect              | Network security                         | Resource permissions (IAM)               |
|---------------------|------------------------------------------|------------------------------------------|
| **Tool**            | Security Groups, NACLs                   | IAM Policies, Roles, Users               |
| **Controls**        | Who can connect to the network           | What a user/service can do               |
| **Example**         | "Allow access to RDS port 3306"          | "Allow EC2 to access S3 via API"        |
| **What it blocks?** | Traffic (IP/port/protocol)               | Actions (e.g.: `s3:GetObject`, `ec2:Start`) |

### Real example:
- You can have an EC2 instance with **network access enabled to S3**, but **without IAM permission** to list objects — so the call fails.
- Or you can have **IAM permission to access the RDS database**, but if the **Security Group doesn't allow traffic on port 3306**, the connection will be blocked.

---

> **Summary**: Network access (Security Group) allows traffic to the resource. Permissions (IAM) authorize what can be done with the resource.


### Example of a use case: VPC + OpenVPN

If you created and isolated resources within a VPC (Virtual Private Cloud), you need some way to reach these resources for development/testing purposes. So installing an OpenVPN on an EC2 allows you to have a secure and isolated connection with everything inside the VPC (RDS, Lambda, etc), without exposing these resources to the internet. That is, only those connected via VPN can access these internal services - if the resource accepts it via Security Group, of course.

![VPC with OpenVPN for secure access to internal resources](./images/openVPNdiagram.png)


### Trade-off:

Instead of configuring everything manually, you can use a ready-made AMI with OpenVPN available on AWS Marketplace or opt for a VPN service offered by Amazon itself. The choice depends on the purpose: for companies, this cost is part of the business; for educational purposes — where the budget is very limited — it's very worth implementing the solution manually to learn and understand the complexity of network isolation in a VPC.
