Let's Encrypt Handshake process-
certificate management is run on server, happens in two steps
1) agent (server) proves to CA that it controls a domain "example.com"
2) agent can request, renew, and revoke certificates for domain

1) Agent asks Let's Encrypt CA what it needs to do to prove it controls "example.com"
2) Let's Encrypt CA issues a set of challenges to agent
--- challenge can be to create new route and insert content
3) Let's Encrypt provides nonce to use in agent's private key
4) Agent completes challenge and puts nonce in private key, now ready for validation
5) If CA can check challenge and key, the agent (identified by public key) is authorized to do certificate management for "example.com". Key pair used by agent is now "authorized key pair"
6) Agent can now do certificate management. Agent sends "Certificate Signing Request" (CSR) to CA asking to issue a certificate for "example.com" with specified public key (agent's server's public key). CSR includes signature by private key and with authorized key.
7) CA verifies both signatures, certificate is issued for "example.com"














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