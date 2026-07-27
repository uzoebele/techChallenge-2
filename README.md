# Tech Challenge 2 – Jenkins CI/CD Deployment on AWS

## Overview

This project deploys a full-stack application consisting of:

- React frontend
- Express backend
- Docker containers
- Amazon ECR image repositories
- Amazon ECS Fargate services
- Application Load Balancer
- Terraform infrastructure
- Jenkins CI/CD pipeline

The frontend calls the backend through the Application Load Balancer. A generated GUID confirms successful communication between the two services.

## Deployed URLs

### Application

http://techchallenge2-alb-1870694266.us-east-1.elb.amazonaws.com

### Jenkins

http://3.83.143.141:8080

Jenkins credentials are not stored in this public repository. Access information is provided separately in the assignment submission.

## Architecture

```text
Internet
   |
Application Load Balancer
   |
   |-- / --------> Frontend ECS Service
   |
   |-- /api -----> Backend ECS Service
                         |
                   Generates GUID