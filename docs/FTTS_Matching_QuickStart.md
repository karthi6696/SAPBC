# FTTS Matching - Quick Start Guide

## What is FTTS Matching?

FTTS Matching automatically links invoice transactions (TTS_SAP) with payment transactions (TTS_ARAP) when:
- Both have Scheme='FTTS'
- PaymentReference matches ReceiptNumber
- Activity='INVOICE' for invoices, Activity='PAYMENT' for payments
- Total amounts match (TestCostWithoutVat = ReceiptAmount)

## 5-Minute Setup

### Step 1: Verify Prerequisites (2 minutes)

Before starting, ensure you have:

1. **Number Series Setup** in General Ledger Setup:
   - LOB-CPMS Matching No. Series (e.g., "LMAT000001")
   - LOB-CPMS Error No. Series (e.g., "LERR000001")

2. **Master Data** exists:
   - Dimension Value: 'FTTS' (Global Dimension 1)
   - Dimension Value: 'INVOICE' (Global Dimension 2)
   - Dimension Value: 'PAYMENT' (Global Dimension 2)

### Step 2: Setup Matching Rules (1 minute)

1. Search for **"FTTS Matching Setup"** in Business Central
2. Click **"Setup/Update Matching Rules"** button
3. Click **Yes** to confirm
4. Note the rule numbers shown in the success message
5. Verify status shows "✓ Rules configured"

### Step 3: Run First Match (2 minutes)

1. On the same page, click **"Run FTTS Matching Process"**
2. Wait for completion message
3. Click **OK**

### Step 4: Review Results

View matched records:
- Search for **"LOB Matching"** and filter by Scheme='FTTS'
- Search for **"CPMS with LOB Matching"** and filter by Scheme='FTTS'

## Daily Operations

### Running Daily Matches

**Option A: Manual Run**
1. Open "FTTS Matching Setup"
2. Click "Run FTTS Matching Process"

**Option B: Automated (Recommended)**
1. Search for "Job Queue Entries"
2. Create New Entry:
   - Object Type: Codeunit
   - Object ID: 85000
   - Parameter String: CPMS-LOB
   - Schedule: Daily at your preferred time (e.g., 9:00 AM)

### Monitoring Performance

Expected processing time:
- **< 1,000 records**: < 30 seconds
- **1,000 - 10,000 records**: 1-3 minutes  
- **10,000 - 20,000 records**: 3-5 minutes

If processing takes longer, see [Performance Troubleshooting](FTTS_Matching_Documentation.md#performance-issues).

## Common Questions

### Q: What if records don't match?

**A:** Records must meet ALL criteria:
- Exact PaymentReference = ReceiptNumber
- Sum of TestCostWithoutVat = Sum of ReceiptAmount
- Both have Status = Unmatched or Error
- Activity filters match (INVOICE for SAP, PAYMENT for ARAP)

### Q: Can I undo a match?

**A:** Yes, manually:
1. Open the matched record
2. Change Matching Status to "Unmatched"
3. This will clear Matching ID and related fields

### Q: How do I fix mismatched amounts?

**A:**
1. Identify the records (PaymentReference/ReceiptNumber)
2. Check individual line amounts
3. Correct any data entry errors
4. Re-run matching process

### Q: What about records with Status='Matched'?

**A:** Already matched records are skipped. The process only looks at:
- Matching Status = Unmatched
- Matching Status = Error

## Need Help?

- **Full Documentation**: [FTTS_Matching_Documentation.md](FTTS_Matching_Documentation.md)
- **Troubleshooting**: See documentation Section "Troubleshooting"
- **Technical Details**: See documentation Section "Technical Implementation"

## Quick Reference

### Key Fields

| Table | Field | Purpose |
|-------|-------|---------|
| TTS_SAP | PaymentReference | Matching key |
| TTS_SAP | TestCostWithoutVat | Amount to compare |
| TTS_SAP | Matching Status | Match result |
| TTS_SAP | Matching ID | Groups matched records |
| TTS_ARAP | ReceiptNumber | Matching key |
| TTS_ARAP | ReceiptAmount | Amount to compare |
| TTS_ARAP | LOB Matching Status | Match result |
| TTS_ARAP | LOB Matching ID | Groups matched records |

### Status Values

- **Unmatched**: Not yet matched, eligible for matching
- **Matched**: Successfully matched with Matching ID
- **Error**: Matching attempted but failed

### Actions Available

| Action | Location | Purpose |
|--------|----------|---------|
| Setup/Update Matching Rules | FTTS Matching Setup | Create or update rules |
| Delete Matching Rules | FTTS Matching Setup | Remove all FTTS rules |
| View Matching Rules | FTTS Matching Setup | See rule configuration |
| Run FTTS Matching Process | FTTS Matching Setup | Execute matching |

---

**Ready to start?** Just search for "FTTS Matching Setup" in Business Central!
