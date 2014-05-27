require 'formula'

class Oniguruma < Formula
  homepage 'http://www.geocities.jp/kosako3/oniguruma/'
  url 'http://www.geocities.jp/kosako3/oniguruma/archive/onig-5.9.5.tar.gz'
  sha1 '804132e1324ef8b940414324c741547d7ecf24e8'

  def install
    ENV.m32
    ENV.append_to_cflags "-arch i386 -m32"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
