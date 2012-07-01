# -*- coding: utf-8 -*-
require 'spec_helper'

describe Dropbox::Sync do
  let(:dir)  { d = Rails.root + "tmp/spec/lib/dropbox/sync"; d.mkpath; d }
  let(:src)  { dir + "wota" }
  let(:dst)  { dir + "dst" }
  let(:sync) { Dropbox::Sync.new(src.to_s, dst.to_s) }

  describe "#parse" do
    def parse
      sync.parse(log)
    end

    context "(アップデートなし)" do
      let(:log) { <<-LOG
sending incremental file list

sent 3147 bytes  received 19 bytes  6332.00 bytes/sec
total size is 240904922  speedup is 76091.26
        LOG
      }

      specify "[]を返す" do
        parse.should == []
      end
    end

    context "(TOPにファイル追加)" do
      let(:log) { <<-LOG
sending incremental file list
wota/
wota/a
wota/etc.tar.gz
wota/var-cache-bind.tar.gz
wota/x

sent 809582 bytes  received 92 bytes  1619348.00 bytes/sec
total size is 809187  speedup is 1.00
        LOG
      }

      specify "ファイル名の配列を返す" do
        parse.should == %W(
wota/a
wota/etc.tar.gz
wota/var-cache-bind.tar.gz
wota/x
)
      end
    end

    context "(TOPにディレクトリ追加)" do
      let(:log) { <<-LOG
sending incremental file list
wota/
wota/xxx/

sent 150 bytes  received 20 bytes  340.00 bytes/sec
total size is 809187  speedup is 4759.92
        LOG
      }

      specify "[]を返す (ディレクトリは無視)" do
        parse.should == []
      end
    end

    context "(ファイル削除)" do
      let(:log) { <<-LOG
sending incremental file list
wota/
deleting wota/x

sent 141 bytes  received 17 bytes  316.00 bytes/sec
total size is 809187  speedup is 5121.44
        LOG
      }

      specify "[]を返す (削除は無視)" do
        parse.should == []
      end
    end

    context "(ファイル削除とファイル追加)" do
      let(:log) { <<-LOG
sending incremental file list
wota/
deleting wota/a
wota/xy

sent 185 bytes  received 36 bytes  442.00 bytes/sec
total size is 809187  speedup is 3661.48
        LOG
      }

      specify "追加ファイルだけ配列で返す" do
        parse.should == ["wota/xy"]
      end
    end

  end
end
