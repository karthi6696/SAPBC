# FTTS Matching Functionality

## Overview

This document describes the new FTTS matching functionality between TTS_SAP and TTS_ARAP tables. The matching process is designed to efficiently handle 12,000+ records daily.

## Purpose

The FTTS matching functionality automatically identifies and links related records between:
- **TTS_SAP (Line of Business - LOB)**: Invoice transactions with Scheme='FTTS'
- **TTS_ARAP (CPMS)**: Payment transactions with Scheme='FTTS'

## Matching Logic

### 1. Filtering Criteria

#### TTS_SAP Filters:
- Scheme = 'FTTS'
- Matching Status = Unmatched OR Error
- Activity = 'INVOICE'

#### TTS_ARAP Filters:
- Scheme = 'FTTS'  
- LOB Matching Status = Unmatched OR Error
- Activity = 'PAYMENT'

### 2. Matching Process

The system uses a two-level hierarchical matching approach:

**Parent Rule:**
- Groups records by PaymentReference (TTS_SAP) and ReceiptNumber (TTS_ARAP)
- Filters by Scheme='FTTS' and Status=Unmatched/Error

**Child Rule:**
- Applies Activity filters (INVOICE for SAP, PAYMENT for ARAP)
- Calculates sum of TestCostWithoutVat for TTS_SAP grouped by PaymentReference
- Calculates sum of ReceiptAmount for TTS_ARAP grouped by ReceiptNumber
- Compares the sums

### 3. Matching Outcome

When the sums match:
- Records are marked as "Matched"
- A unique Matching ID is generated from the "LOB-CPMS Matching No. Series"
- All related records receive the same Matching ID
- Matching Status is updated to "Matched"
- Match Details and Matched By fields are populated

## Setup Instructions

### Prerequisites

1. **General Ledger Setup** must have configured:
   - LOB-CPMS Matching No. Series (for successful matches)
   - LOB-CPMS Error No. Series (for failed matches)

2. **Master Data Requirements:**
   - Dimension Value 'FTTS' must exist in Global Dimension No. 1 (Scheme)
   - Dimension Value 'INVOICE' must exist in Global Dimension No. 2 (Activity)
   - Dimension Value 'PAYMENT' must exist in Global Dimension No. 2 (Activity)

### Step-by-Step Setup

1. **Access Setup Page:**
   - Search for "FTTS Matching Setup" in Business Central
   - Or navigate via: Administration → Setup → FTTS Matching Setup

2. **Create Matching Rules:**
   - Click "Setup/Update Matching Rules" button
   - Confirm the setup dialog
   - System will create two matching rules (Parent and Child)
   - Note the Rule Numbers displayed in the success message

3. **Verify Setup:**
   - Check "Current Status" section shows "✓ Rules configured"
   - Click "View Matching Rules" to review the created rules

4. **Run Matching Process:**
   - Click "Run FTTS Matching Process" button
   - System will process all eligible records
   - A completion message will appear when finished

## Usage

### Manual Matching Process

1. Navigate to "FTTS Matching Setup" page
2. Click "Run FTTS Matching Process"
3. Review matched records in:
   - LOB Matching page (filtered to FTTS)
   - CPMS with LOB Matching page (filtered to FTTS)

### Automated Matching Process

The matching can be scheduled using Job Queue Entries:

1. Create a new Job Queue Entry
2. Set Object Type to Codeunit
3. Set Object ID to 85000 (Matching Process)
4. Set Parameter String to 'CPMS-LOB'
5. Configure schedule (e.g., daily at specific time)

## Performance Considerations

The matching process is optimized for large datasets:

1. **Batched Progress Updates:** Progress dialogs update every 100 records instead of each record
2. **Dictionary-Based Matching:** Uses hash-based lookups for efficient matching
3. **Unique Key Processing:** Each unique PaymentReference/ReceiptNumber is processed only once
4. **Indexed Queries:** Leverages database indexes on Matching Status and Processed Date Time

### Expected Performance

- **Dataset Size:** 12,000+ records per table
- **Processing Time:** Typically 2-5 minutes depending on server resources
- **Memory Usage:** Minimal due to dictionary-based approach
- **Database Impact:** Read operations on source tables, write operations only for matched records

## Matching Rule Details

### Parent Rule Configuration

| Field | Value |
|-------|-------|
| Matching Type | CPMS-LOB |
| Scheme | FTTS |
| LOB Field | PaymentReference (Field 10) |
| CPMS Field | ReceiptNumber (Field 17) |
| LOB Condition | WHERE(Scheme=FILTER(FTTS),Matching Status=FILTER(Unmatched\|Error)) |
| CPMS Condition | WHERE(Scheme=FILTER(FTTS),LOB Matching Status=FILTER(Unmatched\|Error)) |

### Child Rule Configuration

| Field | Value |
|-------|-------|
| Matching Type | CPMS-LOB |
| Scheme | FTTS |
| LOB Field | TestCostWithoutVat (Field 14) |
| CPMS Field | ReceiptAmount (Field 16) |
| LOB Condition | SORTING(PaymentReference) WHERE(Scheme=FILTER(FTTS),Matching Status=FILTER(Unmatched\|Error),Activity=FILTER(INVOICE)) |
| CPMS Condition | SORTING(ReceiptNumber) WHERE(Scheme=FILTER(FTTS),LOB Matching Status=FILTER(Unmatched\|Error),Activity=FILTER(PAYMENT)) |
| Parent Condition No. | (Links to Parent Rule) |

## Troubleshooting

### No Records Matched

**Possible Causes:**
1. No records meet the filtering criteria
2. PaymentReference doesn't match ReceiptNumber
3. Sum of TestCostWithoutVat doesn't equal sum of ReceiptAmount
4. Records already matched (Status not Unmatched/Error)

**Solutions:**
- Review filtered records in TTS_SAP and TTS_ARAP pages
- Check for data quality issues (missing PaymentReference/ReceiptNumber)
- Verify amount calculations
- Check if records need to be reset to Unmatched status

### Performance Issues

**Possible Causes:**
1. Large dataset (>50,000 records)
2. Database server resource constraints
3. Complex filtering conditions

**Solutions:**
- Run during off-peak hours
- Consider filtering by date ranges first
- Check database indexes on key fields
- Review server resources (CPU, Memory, Disk I/O)

### Matching Rules Not Found

**Error:** "No rules configured - Please click 'Setup/Update Matching Rules'"

**Solution:**
1. Run "Setup/Update Matching Rules" from FTTS Matching Setup page
2. If error persists, check user permissions
3. Verify Matching Rules table (85010) is accessible

## Technical Implementation

### Files Added

1. **FTTSMatchingSetup.Codeunit.al** (Codeunit 85050)
   - `SetupFTTSMatchingRules()`: Creates/updates matching rules
   - `CreateParentRule()`: Creates parent filtering rule
   - `CreateChildRule()`: Creates child matching rule
   - `DeleteFTTSMatchingRules()`: Removes all FTTS rules

2. **FTTSMatchingSetup.Page.al** (Page 85050)
   - Configuration and management UI
   - Setup, Delete, View, and Run actions
   - Real-time status display

### Fields Used

#### TTS_SAP (Table 85000)
- Entry No. (1)
- Scheme (3)
- Activity (5)
- PaymentReference (10)
- TestCostWithoutVat (14)
- Matching Status (85005)
- Matching ID (85006)
- Matching Processed Date Time (85007)
- Match Details (85009)
- Matched By (85010)
- Match Type (85011)

#### TTS_ARAP (Table 85001)
- Entry No. (1)
- Scheme (3)
- Activity (5)
- ReceiptAmount (16)
- ReceiptNumber (17)
- LOB Matching Status (85009)
- LOB Matching ID (85010)
- LOB Processed Date Time (85013)
- LOB Match Details (85018)
- LOB Matched By (51)
- LOB Match Type (53)

### Integration Points

The FTTS matching integrates with:
1. **MatchingProcess.Codeunit.al** (85000): Core matching engine
2. **Matching Rules** (Table 85010): Rule storage
3. **General Ledger Setup**: Number series configuration
4. **Job Queue**: Scheduled automation

## Maintenance

### Regular Tasks

1. **Monitor Unmatched Records:**
   - Review TTS_SAP records with Status=Unmatched
   - Review TTS_ARAP records with LOB Matching Status=Unmatched
   - Investigate patterns in unmatched data

2. **Review Matching Performance:**
   - Check Job Queue Entry logs for timing
   - Monitor for increasing processing times
   - Review error logs for matching failures

3. **Data Quality Checks:**
   - Validate PaymentReference format consistency
   - Validate ReceiptNumber format consistency
   - Check for null or empty values in key fields
   - Review amount discrepancies

### Rule Updates

If matching criteria need to be modified:
1. Navigate to "FTTS Matching Setup"
2. Click "Delete Matching Rules"
3. Update the FTTSMatchingSetup.Codeunit.al code with new criteria
4. Redeploy the extension
5. Click "Setup/Update Matching Rules" to recreate rules

## Support

For technical support or questions about FTTS matching functionality:
- Review Business Central error logs
- Check Integration Errors table for detailed error messages
- Contact system administrator
- Review this documentation for troubleshooting steps

## Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-02-10 | Initial implementation of FTTS matching functionality |
