import sys
import pandas as pd
import matplotlib.pyplot as plt

# 检查参数
if len(sys.argv) < 4:
    print("Usage: python plot_wave.py <input.csv> <output.png> <title> [signal1] [signal2] ...")
    sys.exit(1)

df = pd.read_csv(sys.argv[1])
title, out = sys.argv[2], sys.argv[3]

# 如果没指定信号，默认选取所有非 Time 的列
cols = sys.argv[4:] if len(sys.argv) > 4 else \
       [c for c in df.columns if c != "Time"]

# 增大画布尺寸，让信号之间更宽松
fig, ax = plt.subplots(figsize=(12, 1.8 * len(cols) + 2))

# 获取时间轴的范围，用于计算文本偏移量
time_min = df["Time"].min()
time_max = df["Time"].max()
time_range = time_max - time_min
x_offset = time_range * 0.02 if time_range > 0 else 1

# 定义颜色循环
colors = plt.cm.tab10.colors

for i, c in enumerate(cols):
    # 每个信号占据 2 个单位的垂直空间，彻底解决重合问题
    base = (len(cols) - 1 - i) * 2
    
    # 绘制阶梯波形
    ax.step(df["Time"], base + df[c].astype(int), 
            where="post", lw=1.8, color=colors[i % len(colors)])
    
    # 绘制基线（虚线）
    ax.axhline(base, color="#CCCCCC", linestyle="--", lw=0.8, zorder=0)
    
    # 信号名称标签
    ax.text(time_min - x_offset, base + 0.5, c,
            ha="right", va="center", fontsize=11, fontweight="bold")

# 隐藏 Y 轴刻度
ax.set_yticks([])

# 设置 X 轴标签和标题
ax.set_xlabel("Time (ns)", fontsize=12)
ax.set_title(title, fontsize=14, fontweight="bold", pad=15)

# 添加网格线，方便读时间
ax.grid(axis='x', linestyle=':', alpha=0.6)
ax.set_axisbelow(True) # 让网格线在波形下面

# 自动调整边距，防止标签被裁掉
plt.tight_layout()

# 保存图片
plt.savefig(out, dpi=200)
print(f"Successfully wrote: {out}")
