# BC-SAP Integration

Business Central extension for SAP integration, including matching functionality between TTS_SAP (LOB) and TTS_ARAP (CPMS) data.

## Recent Updates

### FTTS Matching Functionality (v23.0.0.49)

New matching functionality has been added to handle FTTS scheme transactions between TTS_SAP and TTS_ARAP tables.

**Key Features:**
- Automated matching based on PaymentReference and ReceiptNumber
- Scheme-specific filtering (FTTS)
- Activity-based filtering (INVOICE for TTS_SAP, PAYMENT for TTS_ARAP)
- Amount comparison (TestCostWithoutVat vs ReceiptAmount)
- Optimized for daily processing of 12,000+ records

**Setup:**
1. Navigate to "FTTS Matching Setup" page
2. Click "Setup/Update Matching Rules"
3. Run matching process via "Run FTTS Matching Process" button

**Documentation:**
See [FTTS Matching Documentation](docs/FTTS_Matching_Documentation.md) for detailed setup and usage instructions.

## Project Structure

```
├── src/
│   ├── codeunit/           # Business logic codeunits
│   ├── page/               # UI pages
│   ├── table/              # Data tables
│   ├── tableextension/     # Table extensions
│   ├── pageextension/      # Page extensions
│   ├── report/             # Reports
│   ├── query/              # Queries
│   ├── enum/               # Enumerations
│   └── permissionset/      # Permission sets
├── docs/                   # Documentation
├── layouts/                # Report layouts
└── app.json               # Extension manifest
```

## Key Components

### Matching Process
- **MatchingProcess.Codeunit.al**: Core matching engine for LOB-CPMS and EOD-CPMS matching
- **FTTSMatchingSetup.Codeunit.al**: FTTS-specific matching rule setup
- **Matching Rules Table**: Configuration table for matching conditions

### Main Tables
- **TTS_SAP** (85000): FTTS/LOB transaction data
- **TTS_ARAP** (85001): CPMS payment/receipt data
- **EOD Staging**: End of Day staging data

### Integration
- Azure Storage integration
- SharePoint export functionality
- SAP journal processing

## Development

**Platform:** Business Central AL Language
**Runtime:** 14.0
**Application:** 26.0.0.0
**ID Range:** 85000 - 85149

## License

Published by: Kerv Digital
Version: 23.0.0.49
