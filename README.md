#  Blockchain Certificate System

Decentralized system to issue and verify academic certificates using Solidity and Smart Contracts on Ethereum.

##  Description
This project allows educational institutions to issue immutable digital certificates on the blockchain, ensuring authenticity and preventing fraud.

##  Features
- Certificate issuance by authorized administrator
- Public certificate verification
-  Certificate revocation in case of fraud
-  Query all certificates of a student
-  Events for tracking issuances and revocations

## Technologies
- Solidity 0.8.24
- Remix IDE
- Ethereum Blockchain

## 📋 Main Functions
- `emitirCertificado()` - Issues a new certificate
- `verificarCertificado()` - Verifies certificate validity
- `revocarCertificado()` - Revokes an existing certificate
- `obtenerCertificadosEstudiante()` - Lists student's certificates

##  How to Use
1. Open [Remix IDE](https://remix.ethereum.org)
2. Copy the code from `Certificados.sol`
3. Compile the contract
4. Deploy on Remix VM or testnet
5. Interact with the contract functions

##  Usage Example
```solidity
// Issue certificate
emitirCertificado(
    0x123..., 
    "Blockchain Development", 
    "John Doe"
);

// Verify certificate with ID #1
verificarCertificado(1);
```

##  Author
Fernando Daniel Balarezo Lalupú- Blockchain Developer Student

##  License
SPDX-License-Identifier: LGPL-3.0-only
