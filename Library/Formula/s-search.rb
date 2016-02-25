require "language/go"

class SSearch < Formula
  desc "Web search from the terminal"
  homepage "https://github.com/zquestz/s"
  url "https://github.com/zquestz/s/archive/v0.4.3.tar.gz"
  sha256 "904b2293ba8018b030b4ded9b9a1b19d1d5af562352e5ef0c0d2c104623eb3ea"

  head "https://github.com/zquestz/s.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1dda533f6ddd4d0c97185bb43df3628abd4867c99d2f924d8c0e833afe73d10a" => :el_capitan
    sha256 "243103272218622655c97af393c683a51c7771786b7f9deb4632de741e2c3c48" => :yosemite
    sha256 "55805254b7856d142fee5dd4f933f0773226284f5a4c04cd5f5100de92273e31" => :mavericks
  end

  depends_on "go" => :build

  go_resource "github.com/mitchellh/go-homedir" do
    url "https://github.com/mitchellh/go-homedir.git",
      :revision => "d682a8f0cf139663a984ff12528da460ca963de9"
  end

  go_resource "github.com/spf13/cobra" do
    url "https://github.com/spf13/cobra.git",
      :revision => "65a708cee0a4424f4e353d031ce440643e312f92"
  end

  go_resource "github.com/zquestz/go-ucl" do
    url "https://github.com/zquestz/go-ucl.git",
      :revision => "9e5940bb3930921a83dcb0f9e20a32e3b1335590"
  end

  go_resource "github.com/NYTimes/gziphandler" do
    url "https://github.com/NYTimes/gziphandler.git",
      :revision => "a88790d49798560db24af70fb6a10a66e2549a72"
  end

  go_resource "github.com/spf13/pflag" do
    url "https://github.com/spf13/pflag.git",
      :revision => "7f60f83a2c81bc3c3c0d5297f61ddfa68da9d3b7"
  end

  go_resource "golang.org/x/text" do
    url "https://go.googlesource.com/text.git",
      :revision => "07b9a78963006a15c538ec5175243979025fa7a8"
  end

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/zquestz").mkpath
    ln_s buildpath, buildpath/"src/github.com/zquestz/s"
    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "build", "-o", "#{bin}/s"
  end

  test do
    assert_equal "https://www.google.com/search?q=homebrew\n",
      shell_output("#{bin}/s -p google -b echo homebrew")
  end
end
