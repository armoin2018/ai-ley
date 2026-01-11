const { Ed25519KeyPair } = require('crypto-ld');
const { v4: uuidv4 } = require('uuid');
const ipfs = require('ipfs-http-client');
const crypto = require('crypto');

class DecentralizedIdentity {
    constructor(ipfsNode) {
        this.ipfs = ipfsNode || ipfs.create();
        this.keyPair = null;
        this.did = null;
        this.document = null;
    }
    
    async generateIdentity() {
        // Generate Ed25519 key pair
        this.keyPair = await Ed25519KeyPair.generate();
        
        // Create DID (Decentralized Identifier)
        this.did = `did:self:${this.keyPair.fingerprint()}`;
        
        // Create DID Document
        this.document = {
            '@context': [
                'https://www.w3.org/ns/did/v1',
                'https://w3id.org/security/suites/ed25519-2020/v1'
            ],
            id: this.did,
            verificationMethod: [{
                id: `${this.did}#keys-1`,
                type: 'Ed25519VerificationKey2020',
                controller: this.did,
                publicKeyMultibase: this.keyPair.publicKeyMultibase
            }],
            authentication: [`${this.did}#keys-1`],
            assertionMethod: [`${this.did}#keys-1`],
            keyAgreement: [`${this.did}#keys-1`],
            service: []
        };
        
        // Store on IPFS
        const result = await this.ipfs.add(JSON.stringify(this.document));
        this.document.ipfsHash = result.cid.toString();
        
        return {
            did: this.did,
            document: this.document,
            privateKey: this.keyPair.privateKeyMultibase
        };
    }
    
    async createVerifiableCredential(subject, claims, issuer) {
        const credential = {
            '@context': [
                'https://www.w3.org/2018/credentials/v1',
                'https://w3id.org/security/suites/ed25519-2020/v1'
            ],
            id: `urn:uuid:${uuidv4()}`,
            type: ['VerifiableCredential'],
            issuer: issuer || this.did,
            issuanceDate: new Date().toISOString(),
            credentialSubject: {
                id: subject,
                ...claims
            }
        };
        
        // Sign the credential
        const signature = await this.signDocument(credential);
        credential.proof = {
            type: 'Ed25519Signature2020',
            created: new Date().toISOString(),
            verificationMethod: `${this.did}#keys-1`,
            proofPurpose: 'assertionMethod',
            proofValue: signature
        };
        
        return credential;
    }
    
    async createVerifiablePresentation(credentials, holder, challenge, domain) {
        const presentation = {
            '@context': [
                'https://www.w3.org/2018/credentials/v1',
                'https://w3id.org/security/suites/ed25519-2020/v1'
            ],
            id: `urn:uuid:${uuidv4()}`,
            type: ['VerifiablePresentation'],
            holder: holder || this.did,
            verifiableCredential: credentials
        };
        
        // Create challenge-response proof
        const proofDocument = {
            ...presentation,
            challenge,
            domain
        };
        
        const signature = await this.signDocument(proofDocument);
        presentation.proof = {
            type: 'Ed25519Signature2020',
            created: new Date().toISOString(),
            verificationMethod: `${this.did}#keys-1`,
            proofPurpose: 'authentication',
            challenge,
            domain,
            proofValue: signature
        };
        
        return presentation;
    }
    
    async signDocument(document) {
        const canonicalDocument = JSON.stringify(document, null, 0);
        const hash = crypto.createHash('sha256').update(canonicalDocument).digest();
        
        const signature = await this.keyPair.signer().sign({ data: hash });
        return Buffer.from(signature).toString('base64');
    }
    
    async verifyCredential(credential) {
        try {
            // Extract issuer DID
            const issuerDid = credential.issuer;
            
            // Resolve issuer's DID document
            const issuerDoc = await this.resolveDID(issuerDid);
            
            // Extract verification method
            const verificationMethod = issuerDoc.verificationMethod
                .find(vm => vm.id === credential.proof.verificationMethod);
            
            if (!verificationMethod) {
                throw new Error('Verification method not found');
            }
            
            // Verify signature
            const { proof, ...credentialWithoutProof } = credential;
            const canonicalDocument = JSON.stringify(credentialWithoutProof, null, 0);
            const hash = crypto.createHash('sha256').update(canonicalDocument).digest();
            
            // Create public key from multibase
            const publicKey = Ed25519KeyPair.fromPublicKeyMultibase({
                publicKeyMultibase: verificationMethod.publicKeyMultibase
            });
            
            const verifier = publicKey.verifier();
            const signatureBuffer = Buffer.from(proof.proofValue, 'base64');
            
            const isValid = await verifier.verify({ data: hash, signature: signatureBuffer });
            
            return {
                valid: isValid,
                issuer: issuerDid,
                subject: credential.credentialSubject.id,
                issuanceDate: credential.issuanceDate
            };
        } catch (error) {
            return {
                valid: false,
                error: error.message
            };
        }
    }
    
    async resolveDID(did) {
        try {
            if (did.startsWith('did:self:')) {
                // For self-sovereign DIDs, resolve from IPFS
                const fingerprint = did.split(':')[2];
                // In practice, you'd have a registry mapping DIDs to IPFS hashes
                // For now, we'll assume the document is stored with a known pattern
                const ipfsHash = await this.lookupDIDInRegistry(did);
                
                if (ipfsHash) {
                    const chunks = [];
                    for await (const chunk of this.ipfs.cat(ipfsHash)) {
                        chunks.push(chunk);
                    }
                    const document = JSON.parse(Buffer.concat(chunks).toString());
                    return document;
                }
            }
            
            throw new Error('DID resolution not supported');
        } catch (error) {
            throw new Error(`Failed to resolve DID ${did}: ${error.message}`);
        }
    }
    
    async lookupDIDInRegistry(did) {
        // In a real implementation, this would query a decentralized registry
        // For example, using a blockchain-based registry or DHT
        // Here we simulate a simple lookup
        
        const registryKey = crypto.createHash('sha256').update(did).digest('hex');
        
        try {
            // Try to get from IPFS using the registry key
            const chunks = [];
            for await (const chunk of this.ipfs.cat(`/registry/${registryKey}`)) {
                chunks.push(chunk);
            }
            const registryEntry = JSON.parse(Buffer.concat(chunks).toString());
            return registryEntry.documentHash;
        } catch {
            return null;
        }
    }
    
    async registerDID(did, documentHash) {
        const registryKey = crypto.createHash('sha256').update(did).digest('hex');
        const registryEntry = {
            did,
            documentHash,
            timestamp: Date.now(),
            signature: await this.signDocument({ did, documentHash })
        };
        
        await this.ipfs.files.write(
            `/registry/${registryKey}`,
            JSON.stringify(registryEntry),
            { create: true }
        );
    }
}

module.exports = DecentralizedIdentity;