class Sslscan2Beta < Formula
  desc "Test SSL/TLS enabled services to discover supported cipher suites"
  homepage "https://github.com/rbsec/sslscan"
  url "https://github.com/rbsec/sslscan/archive/2.0.0-beta1.tar.gz"
  version "2.0.0-beta1"
  sha256 "4a77ddfd0dad740fa1f830feab24702f9ecea8881cfc26d08e82573a4d141023--"
  head "https://github.com/rbsec/sslscan.git"

  bottle do
    cellar :any_skip_relocation
    #sha256 "788f9752e795f4ff95e1251a243a5829a6f9b40facbdca40e4819de5f9d7dc4c" => :catalina
    #sha256 "8a8826da03dbbaa9ee89c8e6b95496c178f5a93d86468402fb6e432ebc7f2c68" => :mojave
    #sha256 "e0735e75b58b7cb0ef72cc79089df545e0140e52bc206c1791ab979192251d22" => :high_sierra
    #sha256 "4b00ee57ccf8dfbc890bbc7ca978dd4f310e7f73dfc022c78c33b69b9b3449dc" => :sierra
  end

  resource "insecure-openssl" do
    url "https://github.com/openssl/openssl/archive/OpenSSL_1_1_1e.tar.gz"
    sha256 "84a30a3f9a23dd5f1e685c176be04b3642b713022c9388177333bb2a730c91ba"
  end

  def install
    (buildpath/"openssl").install resource("insecure-openssl")

    # prevent sslscan from fetching the tip of the openssl fork
    # at https://github.com/PeterMosmans/openssl
    inreplace "Makefile", "openssl/Makefile: .openssl.is.fresh",
                          "openssl/Makefile:"

    ENV.deparallelize do
      system "make", "static"
    end
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "static", shell_output("#{bin}/sslscan --version")
    system "#{bin}/sslscan", "google.com"
  end
end