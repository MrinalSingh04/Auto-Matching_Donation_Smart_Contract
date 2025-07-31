# 🤝 Auto-Matching Donation Smart Contract

## 📝 What 

A smart contract that allows:

- Users to donate ETH to a cause.
- A designated **sponsor** to match user donations **automatically** up to a **cap**.
- All donations and matches to be transparently recorded on-chain.

## 🎯 Why

This encourages more donations by:

- Offering a **psychological nudge** to donors (every donation is matched).
- Giving **corporate sponsors** a way to support causes with **transparency** and control.
- Preventing over-commitment with a **match cap** and controlled sponsor address.

---

## 🔧 Features

- ✅ Tracks each donor’s total contributions
- ✅ Matches user donations 1:1 from sponsor (up to cap)
- ✅ Sponsor can fund the contract separately
- ✅ Owner can withdraw all funds (donations + matched)
- ✅ Allows updating sponsor and cap

---

## 🛡 Security Tips

- Validate sponsor ETH funding before donations are accepted.
- Add timelocks or multi-sig for fund withdrawals in production.
