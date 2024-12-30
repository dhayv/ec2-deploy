# AWS CI/CD Pipeline with CodePipeline, CodeBuild, and CodeDeploy

This repository demonstrates a fully automated deployment pipeline for a React application using AWS services. The pipeline automatically detects changes in your GitHub repository, builds the application, and deploys it to EC2 instances—eliminating the need for manual SSH deployments.

[Link to Blog Post ](https://dev.to/dhayv/ec2-cicd-pipeline-using-aws-codepipeline-codebuild-codedeploy-1p21)
## Architecture

![cloud architecture](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/3zehpnu7t8spv7gs7iny.png)

## Technologies Used

- **GitHub:** Source code repository
- **AWS CodePipeline:** Pipeline orchestration
- **AWS CodeBuild:** Code building and testing
- **AWS CodeDeploy:** Automated deployment
- **Amazon EC2:** Application hosting
- **Amazon S3:** Build artifact storage
- **AWS IAM:** Service permissions management

## Prerequisites

- AWS Account with administrative access
- GitHub account
- Basic understanding of AWS services
- Familiarity with React/Vite applications

## Benefits

- **Automated Deployments:** Eliminate manual SSH deployments and human error
- **Consistent Process:** Ensure every deployment follows the same tested steps
- **Quick Rollbacks:** Easily revert to previous versions if issues arise
- **Enhanced Security:** Remove the need for direct SSH access to production servers
- **Faster Development:** Reduce the time between code commits and production deployment

## Repository Structure

```
├── my-react-app/        # Sample React application
├── buildspec.yml        # CodeBuild instructions
├── appspec.yml         # CodeDeploy configuration
└── scripts/           # Deployment scripts
```

## Setup Instructions

### 1. IAM Role Configuration

#### EC2 Role
1. Create a new role with EC2 as trusted entity
2. Attach `AmazonEC2RoleforAWSCodeDeploy` policy
3. Name the role (e.g., `EC2CodeDeployRole`)

#### CodeDeploy Role
1. Create a new role with CodeDeploy as trusted entity
2. Attach `AWSCodeDeployRole` policy
3. Update trust relationship with provided policy

### 2. EC2 Instance Setup

1. Launch Ubuntu EC2 instance
2. Configure security group (SSH: Port 22, HTTP: Port 80)
3. Attach `EC2CodeDeployRole`
4. Add CodeDeploy agent installation script to user data

### 3. CodeDeploy Configuration

1. Create CodeDeploy application
2. Set up deployment group
3. Configure deployment settings
4. Link to EC2 instances

### 4. CodePipeline Setup

1. Create new pipeline
2. Configure GitHub source connection
3. Set up CodeBuild project
4. Link CodeDeploy deployment

## Configuration Files

### buildspec.yml
```yaml
version: 0.2

phases:
  install:
    runtime-versions:
      nodejs: 20
    commands:
        - cd ./my-react-app
        - npm install
       
  build:
    commands:
        - npm run build
     
artifacts:
  files:
    - 'my-react-app/dist/**/*'
    - 'appspec.yml'
    - 'scripts/**/*'
  discard-paths: no
```

### appspec.yml
```yaml
version: 0.0
os: linux
files:
  - source: /my-react-app/dist
    destination: /var/www/html/
hooks:
  BeforeInstall:
    - location: scripts/before_install.sh
      timeout: 300
      runas: root
  AfterInstall:
    - location: scripts/after_install.sh
      timeout: 300
      runas: root
  ApplicationStart:
    - location: scripts/start_application.sh
      timeout: 300
      runas: root
```

## Troubleshooting

- **CodeDeploy Agent Issues:** Check agent status with `sudo service codedeploy-agent status`
- **Pipeline Failures:** Review CloudWatch logs for detailed error messages
- **EC2 Connectivity:** Ensure security groups allow necessary traffic
- **Build Failures:** Verify buildspec.yml paths and commands

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

- AWS Documentation
- DevOps Community
- React/Vite Documentation
