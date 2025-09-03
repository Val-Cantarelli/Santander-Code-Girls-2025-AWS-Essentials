
# Santander - CodeGirls2025 - AWS-Essentials

> **Repository purpose:** Briefly documents the content covered during the **Santander Code Girls - 2025** bootcamp, offered by the [Dio.me](https://www.dio.me/en) platform, and highlights the implications of using AWS - Amazon Web Services tools. This is not intended to be a tutorial. For detailed and always up-to-date instructions, I recommend consulting the [official AWS documentation](https://docs.aws.amazon.com/).

> **Level:** This bootcamp is introductory and covers basic cloud computing concepts, equivalent to the content required for the **AWS Certified Cloud Practitioner CLF-02 AWS** certification.

---
## Understanding the Cloud Structure

Before AWS, keeping a system in production required:

- Investment in physical servers, power, and space;
- Specialized maintenance team;
- Fixed costs, even without full usage;
- Limited scalability (dependent on new equipment).


The idea of the cloud is abstract, but it is physically built through data centers spread around the world and grouped by regions. For example, let's take South America:

- **Region:** South America.
- **Availability Zone (AZs):** Used to host computing resources (EC2, databases, etc.) and ensure availability and redundancy. There are 3.
    * Note: 1 AZ probably has 2 or more connected data centers.

- **Edge location:** Smaller data centers used to **replicate content** and **reduce latency**, providing data more quickly to customers through the **Amazon CloudFront** service (Content Delivery Network – CDN), for example. Both Edge Locations and AZs are part of AWS's global infrastructure, but Edge Locations are especially accessible for companies that want to deliver content (such as streaming) efficiently in regions like South America, even if the main processing is in another region.

    To learn more, see the [AWS Global Infrastructure](https://aws.amazon.com/about-aws/global-infrastructure/).


Today, what AWS offers is physical and global infrastructure in seconds, and you just use the services. Here we already touch on a very important and initial concept about AWS: the separation of responsibility between AWS and the customer.

## **Shared Responsibility Model:**

- **"Security of the Cloud":** AWS is responsible for the security **OF** the physical structure (data centers, hardware, networks).
- **"Security in the Cloud":** The customer is responsible for security **IN** the cloud. This includes protecting access credentials, keeping operating systems and software up to date, and following best practices when using services. If there is a password leak or a failure due to lack of updates, it is the customer's responsibility.


## **Cloud Service Models: IaaS, PaaS, and SaaS**

In AWS (and other clouds), there are different service models:

- **IaaS (Infrastructure as a Service):** You manage servers, storage, and networks, while AWS takes care of the physical infrastructure. Example: EC2;
- **PaaS (Platform as a Service):** You manage only the applications, while AWS manages the operating system, middleware, and infrastructure. Example: Lambda;
- **SaaS (Software as a Service):** You just use the software, without worrying about infrastructure or platform. Example: any service where you just create an account and use it; Netflix, Gmail, GitHub.

Each model presents a different degree of responsibility between the customer and AWS. For more details on how these responsibilities are distributed in each model, see the [Shared Responsibility Model](https://docs.aws.amazon.com/prescriptive-guidance/latest/strategy-accelerating-security-maturity/understanding-the-security-scope.html).



## Getting Started with the AWS Platform:

### 1. Login and Security (IAM)

- Avoid using the root account for daily tasks;
- Create users with the least privilege and organize them into groups;
- Manage permissions via policies (JSON) — can be AWS Managed or Custom;
- Enable MFA (extra security layer).

### 2. AWS Management Console, AWS CLI, and CloudShell
- **Console:** Accessed via browser. Intuitive, ideal for beginners or specific tasks.
- **CLI (Command Line Interface):** Command-line interface, ideal for automation, scripts, and greater control over services. Requires initial credential configuration and is most used in development.

**Basic examples (AWS CLI):**

```bash
# Configure credentials - allows interaction with AWS public endpoints
aws configure

# List S3 buckets
aws s3 ls

# Describe EC2 instances
aws ec2 describe-instances
```

- **CloudShell:** Environment within AWS. You can't run local scripts, for example, but you can view account and service information.