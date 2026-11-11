import sys
import pandas as pd
import matplotlib.pyplot as plt

if len(sys.argv) < 4:
    print("Usage: python plot_wave.py <input.csv> <title> <output.png> [--start ns] [--end ns] [signal1] [signal2] ...")
    sys.exit(1)

csv_file = sys.argv[1]
title = sys.argv[2]
out = sys.argv[3]
raw_args = sys.argv[4:]

t_start = None
t_end = None
signals = []

i = 0
while i < len(raw_args):
    if raw_args[i] == "--start" and i + 1 < len(raw_args):
        t_start = float(raw_args[i + 1])
        i += 2
    elif raw_args[i] == "--end" and i + 1 < len(raw_args):
        t_end = float(raw_args[i + 1])
        i += 2
    else:
        signals.append(raw_args[i])
        i += 1

df = pd.read_csv(csv_file)

if t_start is not None:
    df = df[df["Time"] >= t_start]
if t_end is not None:
    df = df[df["Time"] <= t_end]

if df.empty:
    print("Error: No data in specified time range!")
    sys.exit(1)

# 自动兼容带 [15:0] 等位宽标记的列名匹配
matched_cols = []
for req in signals:
    found = False
    for col in df.columns:
        if col == req or col.startswith(req + "["):
            matched_cols.append(col)
            found = True
            break
    if not found and req in df.columns:
        matched_cols.append(req)

cols = matched_cols if matched_cols else [c for c in df.columns if c != "Time"]

fig, ax = plt.subplots(figsize=(11, 1.8 * len(cols) + 1.5))

time_min = df["Time"].min()
time_max = df["Time"].max()
time_range = time_max - time_min
x_offset = time_range * 0.02 if time_range > 0 else 1
colors = plt.cm.tab10.colors

def to_digital(val):
    if pd.isna(val):
        return 0
    s = str(val).strip().lower()
    if s in ('x', 'z', 'none', 'nan', '', '0', "b0", "h0", "16'h0000", "0000"):
        return 0
    try:
        v = int(s, 0)
        return 1 if v != 0 else 0
    except ValueError:
        pass
    try:
        v = int(s, 16)
        return 1 if v != 0 else 0
    except ValueError:
        return 1

for idx, c in enumerate(cols):
    base = (len(cols) - 1 - idx) * 2
    wave_data = df[c].apply(to_digital)
    
    ax.step(df["Time"], base + wave_data, where="post", lw=1.8, color=colors[idx % len(colors)])
    ax.axhline(base, color="#CCCCCC", linestyle="--", lw=0.8, zorder=0)
    
    # 简化标签显示，去掉长前缀
    label = c.replace("vga_colorbar_tb.", "")
    ax.text(time_min - x_offset, base + 0.5, label, ha="right", va="center", fontsize=11, fontweight="bold")

ax.set_yticks([])
ax.set_xlabel("Time (ns)", fontsize=12)
ax.set_title(title, fontsize=14, fontweight="bold", pad=15)
ax.grid(axis='x', linestyle=':', alpha=0.6)
ax.set_axisbelow(True)

plt.tight_layout()
plt.savefig(out, dpi=200)
print(f"Successfully generated: {out}")