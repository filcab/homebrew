require 'formula'

class Oniguruma < Formula
  homepage 'http://www.geocities.jp/kosako3/oniguruma/'
  url 'http://www.geocities.jp/kosako3/oniguruma/archive/onig-5.9.3.tar.gz'
  sha1 '235e0ec46582e4dbd12c44aeba97d1219aed6702'

  def install
    ENV.m32
    ENV.append_to_cflags "-arch i386 -m32"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
