# Reddit jp stat

日本語園のRedditについてグラフを書く。


## 使い方

```sh
	# `subreddits.txt`に書かれたサブレディットを取得する。
	# 時間がかかるため注意。
	./get-all.sh -a -b -s  # -> /r/*/submissions.{json,tsv}
	# データを集計する
	./mk-stat.sh                   # -> /data/*.data
	# グラフを書く。
	./plot-stat.sh                 # -> /data/*.png
```

おまけ

```sh
	# スコアの分布とかを集計する。
	( cd r/newsokur; mk-data.sh )   # -> /r/newsokur/*.data
	# そのグラフを書く。
	( cd r/newsokur; ./plot.sh )    # -> /r/newsokur/*.png
	# すべてのサブレディットについて書く場合はこちら。
	./apply-all.sh mk-data.sh       # -> /r/*/*.data
	./apply-all.sh plot.sh          # -> /r/*/*.png
```

```sh
	# `/data/`以下の.dataファイルMarkdownで表にする。
	./to-table.sh  # -> /data/table.md
```

## 集計結果

ユーザ数は一ヶ月の間に一回以上スレッドを立てたユーザの数を表す。

グラフに使ったデータは[data](data/)ディレクトリの`.data`ファイルを参照。
また、こっちで[表](data/table.md)にした。

### 2016/12のランキング

#### スコア数

![スコア](data/scores_2016-12_top.png)

---

#### コメント数

![コメント](data/comments_2016-12_top.png)

---

#### スレッド数

![スレッド](data/threads_2016-12_top.png)

---

#### ユーザ数

![ユーザ](data/users_2016-12_top.png)

---

### 5大サブレの推移

 | 全体版 | ズーム版
--- | --- | ---
スコア | ![グラフ](data/scores_top5_time.png) | ![グラフ](data/scores_top5_time_zoom.png)
コメント | ![グラフ](data/comments_top5_time.png) | ![グラフ](data/comments_top5_time_zoom.png)
スレッド | ![グラフ](data/threads_top5_time.png) | ![グラフ](data/threads_top5_time_zoom.png)
ユーザ | ![グラフ](data/users_top5_time.png) | ![グラフ](data/users_top5_time_zoom.png)


## LICENSE

MIT
