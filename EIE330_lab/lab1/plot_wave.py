import sys
import pandas as pd
import matplotlib.pyplot as plt
df = pd.read_csv(sys.argv[1])
title, out = sys.argv[2], sys.argv[3]
cols = sys.argv[4:] if len(sys.argv) > 4 else \
       [c for c in df.columns if c != "Time"]
fig, ax = plt.subplots(figsize=(10, 0.75 * len(cols) + 1.4))
for i, c in enumerate(cols):
    base = len(cols) - 1 - i
    ax.step(df["Time"], base + df[c].astype(int), where="post", lw=1.7)
    ax.axhline(base, color="#DDDDDD", lw=0.7)
    ax.text(df["Time"].iloc[0] - 1.5, base + 0.5, c,
            ha="right", va="center", fontsize=11)
ax.set_yticks([])
ax.set_xlabel("Time (ns)")
ax.set_title(title)
plt.tight_layout()
plt.savefig(out, dpi=200)
print("wrote", out)
