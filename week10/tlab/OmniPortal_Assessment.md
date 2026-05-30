# OMNI-PORTAL ASSESSMENT REPORT
**Operator:** Sefat E Monzor

## PHASE 1: AUTH BYPASS (SQLi)
* **Payload Used:** ' OR 1=1 --
* **Result:** Successfully bypassed login and obtained 'auth_token' cookie.

## PHASE 2: CLIENT-SIDE HIJACK (XSS)
* **Stored XSS Payload:** <script>alert(document.cookie);</script>
* **Secret Cookie Captured:** _ga=GA1.1.363369834.1776523102; _ga_699NE13B0K=GS2.1.s1776523101$o1$g1$t1776524413$j60$l0$h0; session_id=admin_secret_99812_do_not_share; auth_token=SUPPORT_TIER_1_SECRET_TOKEN


## PHASE 3: API ENUMERATION (BOLA)
* **Insecure Order ID:** 501
* **Confidential Data Leaked:** amount of $15,000.00, confidential server lease order id 501

## PHASE 4: THE REMEDIATION
* **Fix for SQLi:** Use parameterized queries so the database treats user input strictly as harmless data, never as executable code.
* **Fix for XSS:** Use output encoding to turn sketchy characters into plain text, stopping the browser from running them as a script.
* **Fix for API BOLA:** Run an authorization check on every single request to make sure the user actually owns or has rights to that specific ID.
