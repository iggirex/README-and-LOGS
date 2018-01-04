Let's Encrypt Handshake process-
certificate management is run on server, happens in two steps
1) agent (server) proves to CA that it controls a domain "example.com"
2) agent can request, renew, and revoke certificates for domain

--- The first communication happens over HTTP (obviously) and needs webroot access

MORE SPECIFICALLY
1) Agent asks Let's Encrypt CA what it needs to do to prove it controls "example.com"
2) Let's Encrypt CA issues a set of challenges to agent
--- challenge can be to create new route and insert content
3) Let's Encrypt provides nonce to use in agent's private key
4) Agent completes challenge and puts nonce in private key, now ready for validation
5) If CA can check challenge and key, the agent (identified by public key) is authorized to do certificate management for "example.com". Key pair used by agent is now "authorized key pair"
6) Agent can now do certificate management. Agent sends "Certificate Signing Request" (CSR) to CA asking to issue a certificate for "example.com" with specified public key (agent's server's public key). CSR includes signature by private key and with authorized key.
7) CA verifies both signatures, certificate is issued for "example.com"

Our Process very basically:

1) Forward the right ports
2) Set up static assest directory structure and serve it through Express
3) Install and run Certbot
4) Setup Express to use HTTPS
5) Renew your Let's Encrypt certificate


MAKING HTTPS SAMPLE PROJECT WITH LETS ENCRYPT

1) NPM init, install Express, make simple server as app.js:


	const express = require("express");
	const app = express();

	app.get("/health-check", (req, res) => res.sendStatus(200));

	app.use(express.static("static"));

	app.listen(8080);

2) Make file structure for acme challenge and LETS ENCRYPT "echo 'this is a test' > static/.well-known/acme-challenge/9001

3) serve with "node app.js" and check that server is working "curl http://<your_server_url>/.well-known/acme-challenge/9001"
--- Should print out "this is a test" to your console.

4) Install the LETSENCRYPT Cert Bot which will generate our keys and stuff "sudo apt-get install letsencrypt" (problems in Windows, better in Ubuntu)

5) Create private keys "sudo letsencrypt --webroot -w ./static -d <your server url>" 

ERROR: Requested domain is not a FQDN
--> this can point to a server url being wrong, like using http:// or :3000 or something like that

ERROR: Use "certonly flag"

---> CORRECT EXAMPLE:
	sudo letsencrypt certonly --webroot -w ./static -d ec2-34-216-84-185.us-west-2.compute.amazonaws.com

ERROR: "error creating new authz :: policy forbids issuing for name" --> AWS is blacklisted by Let's Encrypt
---> create custom URL name so AWS name is not used, view CREAT FREE CUSTOM URL README for instructions on doing this for free

ERROR: permission to /var/log/letsencrypt/letsencrypt.log denied
---> add "sudo" at beginning of command

ERROR: connection failed to examplesite.com
---> webapp server was not running while doing this command

ERROR: connection failed can't find http://examplesite.tk/.well-known/acme-challenge/fjkdsahdFASHJisfdj8409ojFS390fsFJDsi (can't find key)
---> Web app is being served on port 3000, so now the command should look like this: "sudo letsencrypt certonly --webroot -w ./static -d examplesite.tk:3000"

ERROR: Domain zumdash.tk:3000 is not a FQDN
---> need to serve this on port 80 because Let's Encrypt doesn't like ":" or other weird symbols so we can't https a port on a website. Fuckin eh. Can do port forwarding later so after it hits port 80 it will link to a different port. or not.

---> check that app is being served on plain ole' examplesite.com, without specifying any port. 

ERROR: EACCESS (port 80 already being used by AWS more specifically by load balencers) also this is a type of override permission error
---> bad solution -> run command as sudo to force it to work ERROR, sudo can't find node --> find where node is with "which node", then sudo to that PATH EXAMPLE:

	sudo /home/ubuntu/.nvm/versions/node/v8.9.3/bin/node index.js
WORKS! being served right from "examplesite.tk". great. BUT...
this is the bad way to do it, if someone hacks into this server, they will have root access because it's being served as sudo, so this is a better way described here:
https://medium.com/tfogo/how-to-serve-your-website-on-port-80-or-443-using-aws-load-balancers-a3b84781d730

running "ubuntu@ip-172-31-24-114:$ sudo letsencrypt certonly --webroot -w ./static -d zumdash.tk"
Error: The error was: PluginError('./static does not exist or is not a directory',)
--> must run from top of project directory


CONGRATULATIONS -- MESSAGE ON SUCCESS -- (friggin finally):

	 - Congratulations! Your certificate and chain have been saved at
	   /etc/letsencrypt/live/zumdash.tk/fullchain.pem. Your cert will
	   expire on 2018-04-03. To obtain a new version of the certificate in
	   the future, simply run Let's Encrypt again.
	 - If you like Let's Encrypt, please consider supporting our work by:

	   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
	   Donating to EFF:                    https://eff.org/donate-le


6) OK we got the SSL certs, but not done yet. Out of the box Express only uses HTTP. We can wire up https with the "https" node module.

This will require 2 files (in /etc/letsencrypt/live/zumdash.tk). 1) a certificate and 2) a private key. (never share private key) also recommended copying fullchain.pem and privkey.pem into your project directory or creating symbolic link to them.

Project assumes you have fullchain.pem and privkey.pem in a folder called "sslcert" in project directory

Copy these .pem files into project "sudo cp fullchain.pem ~/projFolder/sslcert"

7) install https, also require 'fs' to read these files, and add them to app.js

app.js should look like:

	const https = require("https");
	const express = require("express");
	const fs = require("fs");

	const app = express();

	//app.use(express.static("static"));

	const options = {
		cert: fs.readFileSync("./sslcert/fullchain.pem"),
		key: fs.readFileSync("./sslcert/privkey.pem")
	};

	app.get("/", (req, res) => {
	  res.send("yo it's yer boi IgMoney WADDDUUUPP!?!")
	})
	app.listen(80, () => console.log("Server running on port 80"));

	https.createServer(options, app).listen(8483);

8) install helmet.js (optional) to help secure express server through setting HTTP headers. This adds HSTS, removes "x-Powered-by" and "X-Frame-Options" to prevent CLICK JACKING attack.

"npm install --save helmet"

add this line to server

	app.use(require("helmet")());

9) Test for green lock on your website to see if HTTPS is up and running

Error: if already in use using sudo, this command is handy to find this "ps auxwf", also "ps auxwf | grep node"


ERROR running server while trying to create keys, 
don't run ./letsencrypt command as sudo























OTHER ATTEMPT DOWN HERE
creating SSL certs and HTTPS


1) make a server with 'fs' included

var express = require('express');
var app = express();
var fs = require('fs');

2) (in server) Ask for certificate files needed to create ssl connection, these are a) private key b) primary certificate c) intermediate certificate

var key = fs.readFileSync('encryption/private.key');
var cert = fs.readFileSync( 'encryption/primary.crt' );
var ca = fs.readFileSync( 'encryption/intermediate.crt' );

4) create these files mentioned above with this terminal command:

openssl req -new -newkey rsa:2048 -nodes -out mydomain.csr -keyout private.key

4.TRICKY) This above command will only create private.key and .mydomain.csr. We still need primary.crt, and this must come from a CA (certificate authority) so $$$ needs to be paid. Here is a way to create your own primary.crt, which is called "self-signed" though it can display an error in the browser saying certificate authority is unknown and untrusted. (Respect my authoroty)

openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

--- server.crt can be "primary.crt" or whatever.

3) create options obj that includes these files

var options = {
  key: key,
  cert: cert,
  ca: ca
};

4) (in server) Listen on correct port for https

var https = require('https');
https.createServer(options, app).listen(443);

5) 
