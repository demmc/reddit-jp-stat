#!/usr/bin/env python3

'''
最初は盛り上がっていたのに最近は過疎っているサブレを探す。
'''

from glob import glob


records = []
for data in glob("r/*/scores-comments-threads-users_time.data"):
    with open(data, 'r') as f:
        lines = f.readlines()

    if len(lines) < 2:
        continue
    score, comment, thread, user = 1, 2, 3, 4
    idx = comment

    # 2つ目のデータと最新のデータを比較する
    # 1つ目のデータはスティッキースレに影響されて大きくなりがちだから
    first, last = lines[1], lines[-1]
    parts = first.split()
    p_first = int(parts[idx])

    parts = last.split()
    p_last = int(parts[idx])
    delta = p_first - p_last
    if delta < 200:
        continue
    
    dir = '/'.join(data.split('/')[:-1])
    records.append((dir, delta))

for r in sorted(records):
    print(*r)
