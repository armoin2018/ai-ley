---
name: 'SAP Instructions'
description: 'Comprehensive instruction set for using SAP, covering core functions such as navigation, data entry, module access (FI, CO, MM, SD), report generation, and transaction execution with step-by-step procedures, system tips, and typical use case workflows.'
keywords: [entry, basic, accounting, access, distribution, custom, execution, cli, controlling, error]
---


# SAP Instructions

## Tool Overview

- **Tool Name**: SAP (Systems, Applications & Products in Data Processing)
- **Version**: SAP ECC 6.0, SAP S/4HANA, SAP NetWeaver
- **Category**: Enterprise Resource Planning (ERP)
- **Purpose**: Integrated business software for managing operations and customer relations
- **Prerequisites**: SAP GUI client, user credentials, authorized access to SAP system

## System Access & Navigation

### SAP GUI Login

1. **Launch SAP GUI**

   
2. **SAP Fiori Launchpad (S/4HANA)**
   
### Basic Navigation

#### Transaction Codes (TCodes)

See [example-1](./examples/sap/example-1.txt)

#### Navigation Menu

- **Menu Bar**: File, Edit, Goto, Favorites, Extras, System, Help
- **Standard Toolbar**: Save, Back, Exit, Cancel, Print, Find, etc.
- **Application Toolbar**: Transaction-specific functions

#### Screen Elements

- **Status Bar**: System messages and information
- **Command Field**: Enter transaction codes
- **Title Bar**: Current transaction and system information

## Core System Functions

### Session Management

#### Multiple Sessions

See [example-2](./examples/sap/example-2.txt)

#### User Settings

See [example-3](./examples/sap/example-3.txt)

### Data Entry Best Practices

#### Field Navigation

- **Tab**: Move to next field
- **Shift+Tab**: Move to previous field
- **Enter**: Validate current field/screen
- **F4**: Value help (dropdown/search)
- **F1**: Field help documentation

#### Data Input Rules

- **Required Fields**: Marked with checkmark or color
- **Format Validation**: Date (DD.MM.YYYY), Numbers, Currency
- **Value Lists**: Use F4 for valid entries
- **Batch Input**: Use templates for bulk data entry

## Module Access & Core Functions

### Financial Accounting (FI)

#### Key Transactions

See [example-4](./examples/sap/example-4.txt)

#### Document Posting Workflow

1. **Enter Transaction**: `/nFB01`
2. **Document Header**:
     3. **Line Items**:
    4. **Validate**: Check document balance
5. **Post**: Save transaction

#### Month-End Procedures

See [example-5](./examples/sap/example-5.txt)

### Controlling (CO)

#### Key Transactions

See [example-6](./examples/sap/example-6.txt)

#### Cost Center Management

1. **Create Cost Center** (`/nKS01`):

      
2. **Budget Planning**:
   
#### Internal Orders

See [example-7](./examples/sap/example-7.txt)

### Materials Management (MM)

#### Key Transactions

See [example-8](./examples/sap/example-8.txt)

#### Purchase Order Process

1. **Create Purchase Requisition** (`/nME51N`):

     
2. **Create Purchase Order** (`/nME21N`):

    
3. **Goods Receipt** (`/nMIGO`):
    
#### Inventory Management

See [example-9](./examples/sap/example-9.txt)

### Sales & Distribution (SD)

#### Key Transactions

See [example-10](./examples/sap/example-10.txt)

#### Order-to-Cash Process

1. **Sales Order Creation** (`/nVA01`):

      
2. **Delivery Processing** (`/nVL01N`):

    
3. **Billing** (`/nVF01`):
    
#### Customer Master Data

See [example-11](./examples/sap/example-11.txt)

## Report Generation

### Standard Reports

#### Financial Reports

See [example-12](./examples/sap/example-12.txt)

#### Controlling Reports

See [example-13](./examples/sap/example-13.txt)

#### Materials Reports

See [example-14](./examples/sap/example-14.txt)

#### Sales Reports

See [example-15](./examples/sap/example-15.txt)

### Report Execution Workflow

1. **Access Transaction**: Enter report transaction code
2. **Selection Screen**:
    3. **Execute**: Press F8 or Execute button
4. **Review Output**:
   
### Custom Reports & Queries

#### SAP Query (SQ01)

See [example-16](./examples/sap/example-16.txt)

#### Report Variants

- **Save Variants**: `/nSE80` → Variants
- **Execute with Variant**: Enter transaction → Goto → Variants → Get

## Transaction Execution Best Practices

### Transaction Flow

1. **Planning Phase**:

    
2. **Execution Phase**:

    
3. **Verification Phase**:
    
### Error Handling

- **Error Messages**: Red messages (blocking)
- **Warning Messages**: Yellow messages (can proceed)
- **Information Messages**: Green messages (informational)
- **Success Messages**: Blue messages (confirmation)

#### Common Error Resolution

See [example-17](./examples/sap/example-17.txt)

## System Tips & Shortcuts

### Keyboard Shortcuts

See [example-18](./examples/sap/example-18.txt)

### Time-Saving Features

#### Favorites Management

See [example-19](./examples/sap/example-19.txt)

#### Batch Input Sessions

See [example-20](./examples/sap/example-20.txt)

#### Mass Processing

See [example-21](./examples/sap/example-21.txt)

### Performance Optimization

- **Limit Selection Criteria**: Use date ranges and specific values

*Content optimized for conciseness. See external references for additional details.*

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
