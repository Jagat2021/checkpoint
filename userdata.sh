#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo service httpd start  
sudo systemctl enable httpd
echo "<h1>Welcome to JAGAT's terraform</h1>" > /var/www/html/index.html
sudo yum install ruby -y
sudo yum install wget -y
cd /home/ec2-user
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start
sudo service codedeploy-agent status

