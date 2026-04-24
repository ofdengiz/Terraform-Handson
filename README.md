# terraform-aws-patterns

Reference Terraform patterns for core AWS provisioning. Each folder is a self-contained Terraform workspace that can be applied independently.

**Stack:** Terraform · AWS · HCL

## Projects

### Project-006 — Kittens Carousel Static Website (S3 + CloudFront + Route 53)

Static website fronted by CloudFront with HTTPS via ACM and a Route 53 alias record. Covers:

- S3 bucket + website configuration
- CloudFront distribution with ACM certificate (DNS-validated)
- Route 53 `A` alias record pointing the subdomain at the distribution
- `for_each` over `domain_validation_options` to automate cert validation

> **Note:** this example uses a public S3 bucket + wildcard `Principal: "*"` policy — the common pattern circa 2023. My current pattern (see [omerdengiz.com](https://omerdengiz.com)) uses **Origin Access Control (OAC)** with a private bucket and a CloudFront service-principal condition.

## For my current Terraform work

My portfolio at **[omerdengiz.com](https://omerdengiz.com)** — a static site on AWS S3 + CloudFront + Lambda@Edge, provisioned with Terraform across two AWS accounts. Source: [`ofdengiz/omerdengiz-com`](https://github.com/ofdengiz/omerdengiz-com).
