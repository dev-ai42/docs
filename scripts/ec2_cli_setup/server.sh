#!/bin/bash

sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo yum install -y git
git clone https://github.com/dev-ai42/test-repo.git
sudo mv test-repo/index.html test-repo/google.css /var/www/html