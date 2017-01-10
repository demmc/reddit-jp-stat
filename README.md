# Reddit jp stat

日本語園のRedditについてグラフを書く。


## 使い方

```sh
	# `subreddits.txt`に書かれたサブレディットを取得する。
	./get-submissions.sh -a -b -s  # -> /r/*/submissions.{json,tsv}
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


## LICENSE

MIT
