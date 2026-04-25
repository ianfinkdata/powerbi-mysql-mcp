# Data Story: Sales by Country & Region

> **Prompt:** Use data storytelling principles to help me find and tell the story in this EDA. Your mission is to come up with several hypotheses on how to either capitalize on opportunities or mitigate churn. No more than 10 options.

---

## The Hook — What the Numbers Say at a Glance

$12.9M in Closed Won revenue. 48 clients. 40 regions. Three countries.

On the surface, the US looks dominant — it has the most clients (28) and the most revenue ($6.6M). But one number changes the story: Canada's **average deal size is $373K**, 58% higher than both the US and Mexico (~$235K each), with a 62.5% regional win rate — the highest of any country.

The data isn't telling a volume story. It's telling an **efficiency** story — and Canada is winning it quietly.

---

## The Tension — What Should Concern Us

Three patterns create structural risk:

**1. Revenue is dangerously concentrated.**
The top 4 regions — AB, CA, QC, CH — generate $7.1M, which is **55% of all revenue from just 7 clients**. A handful of account exits reshapes the entire P&L.

**2. The US has a conversion problem, not a pipeline problem.**
17 of 23 US states (61%) have clients but **$0 in Closed Won revenue**. The coverage is there. The closing isn't.

**3. Mexico is a one-region business.**
CH alone accounts for **$1.53M — 81% of Mexico's $1.9M total**. CX and JA contribute modestly. Five of eight Mexican regions are at zero.

---

## Hypotheses

### Capitalize on Opportunities

**H1 — Double down on Canada before a competitor notices.**
Canada has the highest win rate (62.5%), the highest avg deal size ($373K), and only 12 clients across 8 provinces. The product-market fit signal is strong. Yet Canada is under-resourced relative to the US. The hypothesis: targeted expansion into underrepresented Canadian provinces (MB, BC, ON are already showing early revenue) could yield outsized returns with less competitive friction than the US market.

**H2 — The Ohio account is a blueprint, not an anomaly.**
OH generated $1.5M from a single client — the highest revenue-per-client in the entire US at $1.5M. That's 6x the US average deal size. Understanding this account's industry, segment, and deal structure could reveal a replicable playbook for high-value US wins. The hypothesis: there is a specific customer profile (likely Enterprise, specific industry) that closes significantly larger than average and is under-targeted.

**H3 — Massachusetts is the second US anchor worth scaling.**
MA has a $709K average deal size across 2 clients — 3x the US average. This is not a fluke at n=2 if the profile is consistent. The hypothesis: MA-type accounts (likely financial services or life sciences given geography) represent a higher-value US segment that can be systematically prospected in similar metros (NYC, Chicago, Boston corridor).

**H4 — The US zero-revenue pipeline is a conversion problem worth solving.**
17 US states have at least one client and $0 Closed Won. If even 20–25% of those convert at the US average deal size ($235K), that's $800K–$1M in recoverable revenue from existing accounts — no new logo acquisition required. The hypothesis: these accounts are stalled at a specific stage (likely late funnel) due to a fixable cause — pricing, champion turnover, or product gap — not fundamental disqualification.

**H5 — Mexico has real signals outside CH if you act before CH churns.**
CX ($190K) and JA ($165K) demonstrate that Mexican clients outside CH can close. The hypothesis: proactively investing in CX and JA as secondary anchors now — before CH concentration becomes a liability — is lower cost than emergency pipeline rebuilding after a CH loss.

---

### Mitigate Churn

**H6 — AB is the single largest churn risk in the entire dataset.**
Two clients. $2.2M. $1.1M per client. If either account does not renew, AB drops from the top revenue region to a fraction of its current contribution — and total company revenue takes a visible hit. The hypothesis: AB accounts likely lack a structured success and renewal motion. A dedicated QBR cadence, health scoring, and executive sponsorship program targeted at these two accounts would protect the most concentrated revenue in the portfolio.

**H7 — Mexico's CH dependency is a one-account problem with company-level consequences.**
CH = 81% of Mexico. Mexico = 15% of total revenue. That means one account in one region represents ~12% of all Closed Won. If CH churns or contracts, Mexico's number becomes nearly irrelevant and the company loses a meaningful revenue line. The hypothesis: CH requires a named account retention plan, not just standard CS coverage.

**H8 — The top-4 regional concentration is a business continuity issue.**
AB, CA, QC, and CH together represent 55% of revenue from 7 clients. There is no diversification buffer if multiple accounts exit in the same period. The hypothesis: the company needs a deliberate diversification target — e.g., no single country exceeding 40% of revenue, no single region exceeding 15% — and a 12-month roadmap to move toward it.

**H9 — US zero-revenue clients represent wasted cost, not just missed opportunity.**
The same 17 US states generating $0 in Closed Won still consume sales and CS resources. If these accounts are fundamentally mis-qualified (wrong size, wrong industry, wrong geography), the cost of carrying them exceeds the probability-weighted value of eventual conversion. The hypothesis: a structured qualification audit of these 17 accounts — with a clear stay/exit decision — would free up capacity and improve overall pipeline quality metrics.

**H10 — QC is Canada's hidden concentration risk.**
Canada's story centers on AB, but QC ($1.65M, 2 clients, $825K avg) is quietly in the same fragility zone. Two clients generating nearly 13% of total company revenue from a single province. The hypothesis: QC requires the same retention investment as AB — and the two together should be treated as a "Canada anchor" program, not managed as standard accounts.

---

## Where to Start

If forced to prioritize, these three hypotheses have the clearest signal-to-noise and lowest investigation cost:

| Priority | Hypothesis | Why First |
|---|---|---|
| 1 | H6 — AB retention | Highest single-point revenue risk in the dataset |
| 2 | H1 — Canada expansion | Strong PMF signal, low competitive noise, fastest path to quality revenue |
| 3 | H4 — US zero-revenue conversion | Largest addressable pool with no new logo cost |

---

*Source: bronze_accounts + opportunities · Stage = Closed Won · 40 regions, 48 clients*
