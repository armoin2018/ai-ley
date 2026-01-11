const { create } = require('ipfs-http-client');
const sharp = require('sharp');
const fs = require('fs').promises;

class NFTMetadataGenerator {
    constructor(ipfsUrl = 'https://ipfs.infura.io:5001') {
        this.ipfs = create({ url: ipfsUrl });
        this.traitsDatabase = new Map();
    }
    
    async generateCollection(config) {
        const {
            collectionName,
            description,
            totalSupply,
            layers,
            rarityWeights
        } = config;
        
        const metadata = [];
        const usedCombinations = new Set();
        
        for (let i = 1; i <= totalSupply; i++) {
            let combination;
            do {
                combination = this.generateTraitCombination(layers, rarityWeights);
            } while (usedCombinations.has(JSON.stringify(combination)));
            
            usedCombinations.add(JSON.stringify(combination));
            
            // Generate image
            const imagePath = await this.compositeImage(combination, i);
            const imageHash = await this.uploadToIPFS(imagePath);
            
            // Create metadata
            const tokenMetadata = {
                name: `${collectionName} #${i}`,
                description: description,
                image: `ipfs://${imageHash}`,
                external_url: `https://your-website.com/token/${i}`,
                attributes: this.formatAttributes(combination),
                dna: this.calculateDNA(combination)
            };
            
            metadata.push(tokenMetadata);
            
            // Upload metadata to IPFS
            const metadataHash = await this.uploadJSONToIPFS(tokenMetadata);
            console.log(`Generated token ${i}: ipfs://${metadataHash}`);
        }
        
        // Generate collection metadata
        const collectionMetadata = await this.generateCollectionMetadata(metadata);
        return { metadata, collectionMetadata };
    }
    
    generateTraitCombination(layers, weights) {
        const combination = {};
        
        for (const [layerName, layerTraits] of Object.entries(layers)) {
            const weightedTraits = layerTraits.map(trait => ({
                ...trait,
                weight: weights[layerName]?.[trait.name] || 1
            }));
            
            const selectedTrait = this.weightedRandomSelection(weightedTraits);
            combination[layerName] = selectedTrait;
        }
        
        return combination;
    }
    
    async compositeImage(combination, tokenId) {
        const layers = [];
        
        // Sort layers by z-index
        const sortedLayers = Object.entries(combination)
            .sort(([,a], [,b]) => a.zIndex - b.zIndex);
        
        let composite = sharp({
            create: {
                width: 1000,
                height: 1000,
                channels: 4,
                background: { r: 255, g: 255, b: 255, alpha: 0 }
            }
        });
        
        for (const [layerName, trait] of sortedLayers) {
            if (trait.file) {
                layers.push({ input: trait.file });
            }
        }
        
        const outputPath = `./generated/images/${tokenId}.png`;
        await composite.composite(layers).png().toFile(outputPath);
        
        return outputPath;
    }
    
    calculateRarity(attributes, totalSupply) {
        let rarityScore = 0;
        
        for (const attr of attributes) {
            const traitCount = this.traitsDatabase.get(`${attr.trait_type}:${attr.value}`) || 1;
            const traitRarity = traitCount / totalSupply;
            rarityScore += 1 / traitRarity;
        }
        
        return rarityScore;
    }
    
    async uploadToIPFS(filePath) {
        const file = await fs.readFile(filePath);
        const result = await this.ipfs.add(file);
        return result.cid.toString();
    }
    
    async uploadJSONToIPFS(json) {
        const result = await this.ipfs.add(JSON.stringify(json));
        return result.cid.toString();
    }
}