packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "action_runner_url" {
  description = "The URL to the tarball of the action runner"
  type        = string
  default     = "https://github.com/actions/runner/releases/download/v2.284.0/actions-runner-linux-x64-2.284.0.tar.gz"
}

variable "region" {
  description = "The region to build the image in"
  type        = string
  default     = "us-west-2"
}

source "amazon-ebs" "githubrunner" {
  ami_name      = "peterbean-github-runner-amzn2-x86_64-${formatdate("YYYYMMDDhhmm", timestamp())}"
  instance_type = "m3.medium"
  region        = var.region
  vpc_id        = "vpc-0f4d132cb7be5c967"
  subnet_id     = "subnet-0547e2f94fc137ee9"

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-2.*-x86_64-ebs"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["137112412989"]
  }
  ssh_username = "ec2-user"
  tags = {
    OS_Version    = "amzn2"
    Release       = "Latest"
    Base_AMI_Name = "{{ .SourceAMIName }}"
  }
}

build {
  name = "githubactions-runner"
  sources = [
    "source.amazon-ebs.githubrunner"
  ]

  provisioner "shell" {
    inline = [
      "mkdir -p /home/ec2-user/maven-dependency-bs/src/main/java",
    ]
  }  
      
  provisioner "file" {
    source = "../templates/maven-dependency-bs/pom.xml"
    destination = "/home/ec2-user/maven-dependency-bs/pom.xml"
  }
  
  provisioner "file" {
    source = "../templates/maven-dependency-bs/Application.java"
    destination = "/home/ec2-user/maven-dependency-bs/src/main/java/Application.java"
  }  
    
  provisioner "shell" {
    environment_vars = []
    inline = [
      "sudo yum update -y",
      "sudo yum install -y amazon-cloudwatch-agent curl jq git",
      "sudo amazon-linux-extras install docker",
      "sudo systemctl enable docker.service",
      "sudo systemctl enable containerd.service",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user",
      "sudo yum install -y java-1.8.0-openjdk-devel",
      "echo 'export JAVA_HOME=/etc/alternatives/java_sdk_1.8.0/' >> ~/.bashrc",     
      "echo 'export PATH=$PATH:/home/ec2-user/apache-maven-3.8.4/bin/' >> ~/.bashrc",
      
      "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash",
      "wget https://dlcdn.apache.org/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz",
      "tar xzvf apache-maven-3.8.4-bin.tar.gz",

      "rm apache-maven-3.8.4-bin.tar.gz",
      
      "source ~/.bashrc",
      
      "nvm install 10.24.1",
      "npm install -g @angular/cli@10.2.3",
      
      "cd /home/ec2-user/maven-dependency-bs && mvn install && mvn test && mvn package "
    ]
  }

  provisioner "shell" {
    environment_vars = [
      "RUNNER_TARBALL_URL=${var.action_runner_url}"
    ]
    inline = [templatefile("../install-runner.sh", {
      install_runner = templatefile("../templates/install-runner.sh", {
        ARM_PATCH                       = ""
        S3_LOCATION_RUNNER_DISTRIBUTION = ""
      })
    })]
  }

  provisioner "file" {
    content = templatefile("../start-runner.sh", {
      start_runner = templatefile("../templates/start-runner.sh", {})
    })
    destination = "/tmp/start-runner.sh"
  }

  provisioner "file" {
    content = templatefile("/home/ec2-user/.ssh/aws_ami_cl", {
    })
    destination = "/home/ec2-user/.ssh/id_rsa"
  }
  
  provisioner "shell" {
    inline = [
      "sudo mv /tmp/start-runner.sh /var/lib/cloud/scripts/per-boot/start-runner.sh",
      "sudo chmod +x /var/lib/cloud/scripts/per-boot/start-runner.sh",
    ]
  }

}