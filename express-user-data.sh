#!/bin/bash
apt update -y
apt install curl -y
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs

mkdir -p /home/ubuntu/express-app
cd /home/ubuntu/express-app
npm init -y
npm install express

cat <<EOF > index.js
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => res.send('Hello from Express!'));

app.listen(3000, '0.0.0.0', () => {
  console.log(\`Express app listening on port 3000`);
});
EOF

nohup node index.js > express.log 2>&1 &