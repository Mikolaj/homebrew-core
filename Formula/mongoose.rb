class Mongoose < Formula
  desc "Web server build on top of Libmongoose embedded library"
  homepage "https://github.com/cesanta/mongoose"
  url "https://github.com/cesanta/mongoose/archive/7.0.tar.gz"
  sha256 "28206185873b5c448765f56e54d86a7af5a856b0b5f241aa44ac94bf34af7eee"
  license "GPL-2.0-only"

  bottle do
    cellar :any
    sha256 "180bc1cd1f5aecd01ee647be39884eed4bb0985c82beb39076ff1082a1d56a40" => :big_sur
    sha256 "3eb55e73c26957e647dcc4f978fa7d4d5ae2b223fa631d208f07b341d26ac0d5" => :catalina
    sha256 "cb43e1b9e539db8348d6038fbe56ca787b02428f3c585cd0528c3c4521a26222" => :mojave
    sha256 "a65aaee3abb441a26728b8f08c5fa81845f5636d676fadaba5881da4da04ee71" => :high_sierra
  end

  depends_on "openssl@1.1"

  conflicts_with "suite-sparse", because: "suite-sparse vendors libmongoose.dylib"

  def install
    # No Makefile but is an expectation upstream of binary creation
    # https://github.com/cesanta/mongoose/issues/326
    cd "examples/desktop-server" do
      system "make", "mongoose_mac"
      bin.install "mongoose_mac" => "mongoose"
    end

    system ENV.cc, "-dynamiclib", "mongoose.c", "-o", "libmongoose.dylib"
    include.install "mongoose.h"
    lib.install "libmongoose.dylib"
    pkgshare.install "examples"
    doc.install Dir["docs/*"]
  end

  test do
    (testpath/"hello.html").write <<~EOS
      <!DOCTYPE html>
      <html>
        <head>
          <title>Homebrew</title>
        </head>
        <body>
          <p>Hi!</p>
        </body>
      </html>
    EOS

    begin
      pid = fork { exec "#{bin}/mongoose" }
      sleep 2
      assert_match "Hi!", shell_output("curl http://localhost:8000/hello.html")
    ensure
      Process.kill("SIGINT", pid)
      Process.wait(pid)
    end
  end
end
