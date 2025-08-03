1. Create main.tf
2. Create variables.tf
3. Creaate outputs.tf
4. Create flask-user-data.sh for flask
5. Create express-user-data.sh for express page
6. Use the Public Key File and update in terraform.tfvars
7. Extract Public key from pem file using "ssh-keygen -y -f ~/.ssh/part1-key.pem > part1-key.pub"
8. Move the pub key to terraform folder "mv part1-key.pub ~/projects/flask-express-deployment/"
9. Update Terraform Config
10. Initiate and Apply Terraform
11. Update packages for flask, run and test from browser
12. Use "nohup python3 app.py > flask.log 2>&1 &" to run continously
13. Update Packages for express, node and test from browser
14. use "nohup node index.js > express.log 2>&1 &" for continous run
15. Make .gitignore file and upload in Github
