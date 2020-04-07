class TcpingGo < Formula
  desc "Ping over a tcp connection"
  homepage "https://github.com/cloverstd/tcping/releases"
  # https://github.com/cloverstd/homebrew-tap/blob/master/tcping-go.rb
  #url "https://github.com/cloverstd/tcping/releases/download/v0.1.1/tcping-darwin-amd64-v0.1.1.tar.gz"
  url "https://github.com/cloverstd/tcping/releases/download/v0.1.1/tcping-linux-amd64-v0.1.1.tar.gz"
  sha256 "c8dd30aab120fdae193cf2ca334fe76d3072b55fcb481b5f49db701321350706"

  def install
    bin.install "tcping"
  end

  test do
    system "#{bin}/tcping", "www.google.com", "80"
  end
end
