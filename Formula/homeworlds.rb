class Homeworlds < Formula
  desc "C++ framework for the game of Binary Homeworlds"
  homepage "https://github.com/Quuxplusone/Homeworlds/"
  url "https://github.com/Quuxplusone/Homeworlds.git",
      revision: "917cd7e7e6d0a5cdfcc56cd69b41e3e80b671cde"
  version "20141022"
  license "BSD-2-Clause"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "4a024da7560148c9d94c347226e325968fd087c09610ee14757c618eaf6d52f1"
    sha256 cellar: :any, big_sur:       "d6a22f3c56da49ec935804ed17594b8a82a8114781d953b0c3315330eb64ef18"
    sha256 cellar: :any, catalina:      "a31bff64509e705b514068d75a4bdd6b9e11fa1f0e0aa45bef8b6ecb2b10c7be"
    sha256 cellar: :any, mojave:        "9998b77fea42a5c72c4ffdab61b84165ae8ce067763e4c661a058235749eaf84"
    sha256 cellar: :any, high_sierra:   "b26fbb5f7955afa48247667b0caeff13d504eee6ef744284c498702026f9528e"
    sha256 cellar: :any, sierra:        "499e9a94e24c8965b9a31902ab2a14a021c780756451b82ac2313c7c86ac5756"
    sha256 cellar: :any, el_capitan:    "2665c0ed4da2eb399314d044699385250ca5db54e6f8c22287222b7877881d22"
    sha256 cellar: :any, yosemite:      "47251f13fa79c98b3c41d45cafade044bded134256f56e6ee1a118f67eb325d8"
  end

  depends_on "wxmac"

  def install
    system "make"
    bin.install "wxgui" => "homeworlds-wx", "annotate" => "homeworlds-cli"
  end
end
