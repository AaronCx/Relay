# Export compliance (encryption)

Relay uses standard SSH encryption via SwiftNIO SSH / Citadel (and Apple's
CryptoKit for key generation). That makes it **exempt** under category 5D002
mass-market / standard-protocol provisions, but it still requires the annual
self-classification report.

## App Store Connect answers

| Question | Answer |
|---|---|
| Does your app use encryption? | **Yes** |
| Does your app qualify for any of the exemptions provided in Category 5, Part 2? | **Yes** — it only uses encryption within standard protocols (SSH/TLS) and Apple's OS crypto |
| Is your app going to be available in France? | Yes (standard exemption covers it) |

`ITSAppUsesNonExemptEncryption` is already set to `NO` in the Info.plist
(see `project.yml`), so App Store Connect won't re-ask per build.

## Annual BIS self-classification report

Due **by February 1 each year** for the prior calendar year. One email with a
CSV to BIS and the ENC Encryption Request Coordinator:

- To: `crypt-supp8@bis.doc.gov`, `enc@nsa.gov`
- Subject: `Self-classification report for encryption items — [year]`
- CSV columns and an example row:

```csv
PRODUCT NAME,MODEL NUMBER,MANUFACTURER,ECCN,AUTHORIZATION TYPE,ITEM TYPE,SUBMITTER NAME,TELEPHONE NUMBER,E-MAIL ADDRESS,MAILING ADDRESS
Relay,N/A,Aaron Character,5D992.c,MMKT,Mobility and mobile applications n.e.s.,Aaron Character,[PHONE],[EMAIL],[ADDRESS]
```

Reference: 15 CFR §742.15(b) and Apple's "Complying with Encryption Export
Regulations" documentation.
