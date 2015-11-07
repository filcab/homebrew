class Automake114 < Formula
  homepage "http://www.gnu.org/software/automake/"
  url "http://ftpmirror.gnu.org/automake/automake-1.14.tar.gz"
  mirror "http://ftp.gnu.org/gnu/automake/automake-1.14.tar.gz"
  sha1 "648f7a3cf8473ff6aa433c7721cab1c7fae8d06c"

   bottle do
    sha1 "d4b453a2c8d0f4c0cefa499a8f658448d781225e" => :mavericks
    sha1 "bbbd4cc22501df3e747596d4bfd02cba987fc852" => :mountain_lion
    sha1 "8ee87f97dc533fd1b86a46dff0b05d831070c6cb" => :lion
  end

  depends_on "autoconf" => :run

  keg_only :provided_until_xcode43

  def install
    ENV["PERL"] = "/usr/bin/perl"

    system "./configure", "--prefix=#{prefix}"
    system "make", "install"

    # Our aclocal must go first. See:
    # https://github.com/Homebrew/homebrew/issues/10618
    (share/"aclocal/dirlist").write <<-EOS.undent
      #{HOMEBREW_PREFIX}/share/aclocal
      /usr/share/aclocal
    EOS
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      int main() { return 0; }
    EOS
    (testpath/"configure.ac").write <<-EOS.undent
      AC_INIT(test, 1.0)
      AM_INIT_AUTOMAKE
      AC_PROG_CC
      AC_CONFIG_FILES(Makefile)
      AC_OUTPUT
    EOS
    (testpath/"Makefile.am").write <<-EOS.undent
      bin_PROGRAMS = test
      test_SOURCES = test.c
    EOS
    system bin/"aclocal"
    system bin/"automake", "--add-missing", "--foreign"
    system "autoconf"
    system "./configure"
    system "make"
    system "./test"
  end
end
